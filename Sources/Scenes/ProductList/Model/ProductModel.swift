//
//  ProductModel.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation

struct ProductModel: Codable {
    let name: String
    let imageURL: String
    let description: String
}

extension ProductModel: Equatable {
    static public func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.name == rhs.name
            && lhs.imageURL == rhs.imageURL
            && lhs.description == rhs.description
    }
}
