//
//  SpotlightModel.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation

struct SpotlightModel: Codable {
    let name: String
    let bannerURL: String
    let description: String
}

extension SpotlightModel: Equatable {
    static public func == (lhs: SpotlightModel, rhs: SpotlightModel) -> Bool {
        return lhs.name == rhs.name
            && lhs.bannerURL == rhs.bannerURL
            && lhs.description == rhs.description
    }
}
