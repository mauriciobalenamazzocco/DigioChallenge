//
//  ProductPreviewModel.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation

struct ProductPreview {
    let image: String
    let title: String
    let description: String
    let isImageSquare: Bool
}

extension ProductPreview: Equatable {
    static public func == (lhs: ProductPreview, rhs: ProductPreview) -> Bool {
        return lhs.image == rhs.image
            && lhs.title == rhs.title
            && lhs.description == rhs.description
            && lhs.isImageSquare == rhs.isImageSquare
    }
}
