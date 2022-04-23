//
//  URLSessionProtocol.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

public protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
extension URLSessionDataTask: URLSessionDataTaskProtocol {}
