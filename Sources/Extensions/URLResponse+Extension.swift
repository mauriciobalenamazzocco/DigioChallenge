//
//  URLResponse+Extension.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation

extension URLResponse {
    public var httpDebugDescription: String {
        if let resp = self as? HTTPURLResponse {
            var string = "\t\(resp.statusCode) \(self.url?.absoluteString ?? "")\n"
            for (key, value) in resp.allHeaderFields {
                string.append("\n\t\(key): \(value)")
            }
            return string
        } else {
            return self.debugDescription
        }
    }
    
    var http: HTTPURLResponse? {
        return self as? HTTPURLResponse
    }
}
