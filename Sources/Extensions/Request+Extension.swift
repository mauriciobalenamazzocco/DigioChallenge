//
//  Request+Extension.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation
import os.log

extension Request {
    
    func resume(session: URLSessionProtocol, then: @escaping (Either<Data?>) -> Void) {
        do {
            let req = try self.asURLRequest()
            
            os_log("--- REQUESTING {\n%@\n}", type: .debug, req.httpDebugDescription)

//            let session = URLSession(configuration: URLSessionConfiguration.default,
//                                             delegate: self,
//                                             delegateQueue: OperationQueue.main)

            session.dataTask(
                with: req,
                completionHandler: { (data, resp, err) in
                    self.processResponse(req: req, resp: resp, respData: data, err: err, then: then)
                }
            ).resume()
            
        } catch let error as NSError {
            let err = APIError.uncategorized(statusCode: error.code,
                                               errorDescription: error.localizedDescription)
            then(.failure(err))
        }
    }
    
    private func processResponse(req: URLRequest,
                                 resp: URLResponse?,
                                 respData: Data?,
                                 err: Error?,
                                 then: @escaping (Either<Data?>) -> Void) {
        
        os_log("--- RESPONDED {\n%@\n\n\t%@\n}",
               type: .debug,
               resp?.httpDebugDescription ?? "Response object was null",
               String(data: respData ?? Data(), encoding: .utf8)!)
        
        // Has any type of error?
        if let err = err {
            let code = (err as NSError).code
            let fErr = APIError.uncategorized(statusCode: code,
                                                errorDescription: err.localizedDescription)
            
            then(.failure(fErr))
            return
            
            // Is it http error?
        } else if let resp = resp,
                  let httpError = self.httpErrorToApiError(resp: resp, data: respData) {
            then(.failure(httpError))
            return
        }
        
        then(.success(respData))
        return
    }
    
    private func httpErrorToApiError(resp: URLResponse, data: Data?) -> APIError? {
        guard let httpResp = resp as? HTTPURLResponse else { return nil }
        guard !(200..<400 ~= httpResp.statusCode) else { return nil }
        
        let parseResult: Either<ApiErrorResponse> = data.parseCodableContent()
        
        if case let .success(apiError) = parseResult {
            let detailedMessage = apiError.detailedMessage != nil && (apiError.message != apiError.detailedMessage)
                ? "\r\n\(apiError.detailedMessage!)"
                : ""
            
            return .businessError(message: "\(apiError.message ?? "")\(detailedMessage)")
            
        } else if APIError.HTTPStatusCode(rawValue: httpResp.statusCode) != nil {
            return .httpError(code: httpResp.statusCode, data: data)
            
        } else if !(200..<300 ~= httpResp.statusCode) {
            return .httpError(code: httpResp.statusCode, data: data)
            
        } else {
            return nil
        }
    }
}
