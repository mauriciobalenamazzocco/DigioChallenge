//
//  CashModel.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation

struct CashModel: Codable {
    let title: String
    let bannerURL: String
    let description: String
}

extension CashModel: Equatable {
    static public func == (lhs: CashModel, rhs: CashModel) -> Bool {
        return lhs.title == rhs.title
            && lhs.bannerURL == rhs.bannerURL
            && lhs.description == rhs.description
    }
}
