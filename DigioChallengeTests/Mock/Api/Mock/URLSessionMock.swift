//
//  URLSessionMock.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
@testable import DigioChallenge

class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, urlResponse, error)
        return URLSessionDataTaskSpy()
    }
}
