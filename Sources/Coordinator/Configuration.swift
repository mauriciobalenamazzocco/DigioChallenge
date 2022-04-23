//
//  MainCoordinatorConfiguration.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation

public protocol ConfigurationProtocol {
    var enviroment: Enviroment { get set }
}

public struct Configuration: ConfigurationProtocol {
    public var enviroment: Enviroment

    public init(enviroment: Enviroment = .production) {
        self.enviroment = enviroment
    }
}
