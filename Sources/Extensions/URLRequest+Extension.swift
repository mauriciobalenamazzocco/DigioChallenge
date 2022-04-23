//
//  URLRequest+Extension.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation

extension URLRequest {
    public var httpDebugDescription: String {
        var string = "\t\(self.httpMethod ?? "") \(self.url?.absoluteString ?? "")\n"
        for (key, value) in (self.allHTTPHeaderFields ?? [:]) {
            string.append("\n\t\(key): \(value)")
        }
        if let body = self.httpBody,
            let bodyString = String(data: body, encoding: .utf8) {
            string.append("\n\n\t\(bodyString)")
        } else {
            string.append("\n\nCannot convert body to UTF8 string")
        }

        return string
    }
}
