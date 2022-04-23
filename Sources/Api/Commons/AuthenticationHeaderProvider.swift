//
//  AuthenticationHeaderProvider.swift
//  IonAuthenticator
//
//  Created by Mauricio Balena Mazzocco on 11/05/21.
//

import Foundation

public protocol AuthenticationHeaderProvider {
    func headerValue(for req: URLRequest) -> String?
    func userAgentValue(for req: URLRequest) -> String?
}
