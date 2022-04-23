//
//  Request.swift
//  IonAuthenticator
//
//  Created by Mauricio Balena Mazzocco on 11/05/21.
//

import Foundation

/// Http supported methods
enum HttpMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

/// The data to be sent in a request.
enum RequestData {
    case queryString([(String, Any?)])
    case formEncoded([String: String])
    case json(Any)
    case jsonData(Data)
    case jsonCodable(Codable)
    case pathParam([String: String])
    case header([String: String])
    case none

    private func applyQueryParams(req: inout URLRequest, params: [(String, Any?)]) {
        guard !params.isEmpty,
            let url = req.url,
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }

        let existingQuery = urlComponents.percentEncodedQuery.map { $0 + "&" } ?? ""
        let newQuery = safeJoinQueryParameters(params: params)

        urlComponents.percentEncodedQuery = existingQuery + newQuery
        req.url = urlComponents.url
    }

    private func safeJoinQueryParameters(params: [(String, Any?)]) -> String {
        return params
            .filter { $0.1 != nil }
            .map { (key, value) in (key, value!) }
            .flatMap(expandParameterValue)
            .sorted(by: <)
            .map { (key, value) in "\(key)=\(value)" }
            .joined(separator: "&")
    }

    private func expandParameterValue(key: String, value: Any) -> [(String, String)] {
        switch value {
        case let list as [Any]:
            return list
                .map { escapeQueryParam("\($0)") }
                .map { (escapeQueryParam(key), $0) }

        case let bool as Bool:
            return [(escapeQueryParam(key), bool ? "true" : "false")]

        default:
            return [(escapeQueryParam(key), escapeQueryParam("\(value)"))]
        }
    }

    private func escapeQueryParam(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@/" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;=/"
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String()
        return escaped
    }

    private func escapedPathParm(_ string: String) -> String {
        let reservedCharsToEncode = ";/?:@=&"
        let unsafeCharsToEncode = "\" <>#%{}|\\^~[]"
        var allowedCharacterSet = CharacterSet.urlPathAllowed
        allowedCharacterSet.remove(charactersIn: "\(reservedCharsToEncode)\(unsafeCharsToEncode)")
        let escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String()
        return escaped
    }

    private func applyFormUrlEncoded(req: inout URLRequest, params: [String: String]) {
        guard !params.isEmpty,
            let method = req.httpMethod,
            !(method.caseInsensitiveCompare("get") == .orderedSame) else { return }

        req.setValue("application/x-www-form-urlencoded; charset=utf-8",
                     forHTTPHeaderField: "Content-Type")

        let castParams = params.compactMap { key, value in (key, value as Any?) }
        let data = safeJoinQueryParameters(params: castParams).data(using: .utf8, allowLossyConversion: false)

        req.httpBody = data
    }

    private func applyJsonEncoded(req: inout URLRequest, json: Any) {
        guard let method = req.httpMethod,
            !(method.caseInsensitiveCompare("get") == .orderedSame) else { return }

        req.setValue("application/json",
                     forHTTPHeaderField: "Content-Type")

        let data = try? JSONSerialization.data(withJSONObject: json)
        req.httpBody = data
    }

    private func applyJsonDataEncoded(req: inout URLRequest, jsonData: Data) {
        guard let method = req.httpMethod,
            !(method.caseInsensitiveCompare("get") == .orderedSame) else { return }

        req.setValue("application/json",
                     forHTTPHeaderField: "Content-Type")

        req.httpBody = jsonData
    }

    private func applyJsonCodable(req: inout URLRequest, value: Encodable) {
        if let data = value.encode() {
            applyJsonDataEncoded(req: &req, jsonData: data)
        }
    }

    private func applyPathParams(req: inout URLRequest, params: [String: String]) {
        let path = params.reduce(into: req.url!.absoluteString) {
            $0 = $0.replacingOccurrences(of: $1.key, with: escapedPathParm($1.value))
        }
        req.url = URL(string: path)
    }

    private func applyHeaders(req: inout URLRequest, headers: [String: String]) {
        for (key, value) in headers {
            req.setValue(value, forHTTPHeaderField: key)
        }
    }

    func apply(request req: inout URLRequest) {
        switch self {
        case .none:
            return

        case let .queryString(params):
            applyQueryParams(req: &req, params: params)

        case let .formEncoded(params):
            applyFormUrlEncoded(req: &req, params: params)

        case let .json(json):
            applyJsonEncoded(req: &req, json: json)

        case let .jsonData(jsonData):
            applyJsonDataEncoded(req: &req, jsonData: jsonData)

        case let .jsonCodable(value):
            applyJsonCodable(req: &req, value: value)

        case let .pathParam(params):
            applyPathParams(req: &req, params: params)

        case let .header(headers):
            applyHeaders(req: &req, headers: headers)
        }
    }
}

protocol RequestProtocol {
    var domain: String { get set }
    var path: String { get set }
    var method: HttpMethod { get set }
    var pathParams: [ String: String] { get set }
    var data: [RequestData] { get set }
    var headers: [ String: String] { get set }
    var authenticationProvider: AuthenticationHeaderProvider? { get set }
}
/// Represents a request to be sent to  server.
class Request: NSObject, RequestProtocol {
    var domain: String
    var path: String
    var method: HttpMethod
    var pathParams: [String: String]
    var data: [RequestData]
    var headers: [String: String]
    var authenticationProvider: AuthenticationHeaderProvider?

    init(domain: String,
         path: String,
         method: HttpMethod,
         data: [RequestData] = [],
         authenticationProvider provider: AuthenticationHeaderProvider? = nil) {

        self.domain = domain
        self.path = path
        self.method = method
        self.data = data
        self.authenticationProvider = provider
        self.headers = [:]
        self.pathParams = [:]
    }

    func asURLRequest() throws -> URLRequest {
        if self.domain.isEmpty || self.path.isEmpty {
            throw APIError.uncategorized(statusCode: 500, errorDescription: "Domain and Path must be not empty")
        }
        let fullUrlString = safeJoinPath(basePath: self.domain, path: self.path)
        let url = URL(string: fullUrlString)!

        var req = URLRequest(url: url)
        req.httpMethod = method.rawValue

        for data in self.data {
            data.apply(request: &req)
        }

        if let provider = authenticationProvider {
            req.setValue(provider.headerValue(for: req), forHTTPHeaderField: "Authorization")
            req.setValue(provider.userAgentValue(for: req), forHTTPHeaderField: "User-Agent")
        }

        return req
    }

    private func safeJoinPath(basePath: String, path: String) -> String {
        let normalizedBasePath = basePath.last == "/"
            ? String(basePath.dropLast(1))
            : basePath

        let normalizedPath = !path.isEmpty && path.first != "/"
            ? "/\(path)"
            : path

        return "\(normalizedBasePath)\(normalizedPath)".trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

private extension Encodable {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
