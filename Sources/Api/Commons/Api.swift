//
//  Api.swift
//  IonAuthenticator
//
//  Created by Mauricio Balena Mazzocco on 11/05/21.
//

import Foundation
import os.log

protocol Api {
    
    var session: URLSessionProtocol { get }
    var domain: String { get }

    var authProvider: AuthenticationHeaderProvider? { get }
    
    /// Request with return
    /// - Parameters:
    ///   - provider: Provider
    ///   - completion: Request result
    func resumeToEntity<T: Codable>(req: Request,
                                    completion: @escaping (Either<T>) -> Void)
    /// Request without return
    /// - Parameters:
    ///   - provider: Provider
    ///   - completion: Request result
    func resume(req: Request,
                completion:  @escaping (Either<Void>) -> Void)
    
    init(domain: String, session: URLSessionProtocol, authProvider: AuthenticationHeaderProvider?)
    
}

extension Api {

    func resumeToEntity<T: Codable>(req: Request,
                                    completion: @escaping (Either<T>) -> Void) {
     
        req.resume(session: self.session, then: { (resp) in
            switch resp {
            case let .success(data):
                let serialized: Either<T> = data.parseCodableContent()
                completion(serialized)

            case let .failure(.httpError(code, data)):
                completion(parseError(code: code, data: data))

            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
    
    func resume(req: Request,
                completion: @escaping (Either<Void>) -> Void) {

        req.resume(session: self.session, then: { (resp) in
            switch resp {
            case .success:
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
}

private func parseError<T: Codable>(code: Int, data: Data?) -> Either<T> {
    // Here I have a chance to customize the parse form different error codes.
    let either: Either<ApiErrorResponse> = data.parseCodableContent()
    
    guard case let .success(apiError) = either,
          400..<500 ~= code else {

              return .failure(.httpError(code: code, data: data))
          }
    
    let detailedMessage = apiError.detailedMessage != nil ? "\r\n\(apiError.detailedMessage!)" : ""

    return .failure(.businessError(message: "\(apiError.message ?? "")\(detailedMessage)"))
}
