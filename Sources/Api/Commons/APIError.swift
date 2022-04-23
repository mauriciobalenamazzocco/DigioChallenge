//
//  APIError.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//
import Foundation

/// API  Errors
public enum APIError: Error, Equatable {

    /// Common HTTP Status codes
    ///
    /// - badRequest: The server cannot or will not process the request due to an apparent client error
    /// - unauthorized: Authentication is required and has failed or has not yet been provided
    /// - forbidden: The user might not have the necessary permissions for a resource
    /// - notFound: The requested resource could not be found
    /// - serverError: The server failed to fulfill an apparently valid request
    public enum HTTPStatusCode: Int, Equatable {
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case serverError = 500
    }

    /// The content from response message could not be serialized into specified type.
    case serialization(type: Any.Type)

    /// The error is not yet categorized but it is a networking error
    case uncategorized(statusCode: Int?, errorDescription: String)

    /// HTTP Status code Error
    case httpError(code: Int, data: Data?)

    /// Custom message from server side to describe an error.
    case businessError(message: String)

    ///
    /// - Parameters:
    ///   - lhs: left side ApiError
    ///   - rhs: right side ApiError
    /// - Returns: Comparation result
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        // swiftlint:disable identifier_name
        switch (lhs, rhs) {
        case (.serialization, .serialization): return true
        case (.uncategorized(let a, let b), .uncategorized(let x, let y)) where a == x && b == y : return true
        case (.httpError(let a, _), .httpError(let b, _)) where a == b: return true
        case (.businessError(let a), .businessError(let b)) where a == b: return true
        default: return false
        }
        // swiftlint:enable identifier_name
    }
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        return self.description
    }
}

extension APIError: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .serialization(type):
            return I18n.APIError.serialization.text(with: (String(describing: type)))

        case .uncategorized(_, let errorDescription):
            return "\(errorDescription)"

        case .httpError(let code, _):
            guard let httpCode = HTTPStatusCode(rawValue: code) else { return "" }
            switch httpCode {
            case .badRequest:
                return I18n.APIError.badRequest.text
            case .forbidden:
                return I18n.APIError.forbidden.text
            case .notFound:
                return I18n.APIError.notFound.text
            case .serverError:
                return I18n.APIError.serverError.text
            case .unauthorized:
                return I18n.APIError.unauthorized.text
            }

        case .businessError(let message):
            return message
        }
    }
}
