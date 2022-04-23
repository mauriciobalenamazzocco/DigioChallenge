//
//  ProductHelper.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation

struct ProductHelper {
    static func convertToSectionDisplay(response: ProductContainerResponse) -> [ProductSectionDisplay] {
        var display: [ProductSectionDisplay] = []

        let spotlight = response.spotlight.map {
            ProductPreview(
                image: $0.bannerURL,
                title: $0.name,
                description: $0.description,
                isImageSquare: false
            )
        }
        display.append(
            ProductSectionDisplay(
                title: nil,
                content: spotlight)
        )

        let cash = ProductPreview(
            image: response.cash.bannerURL,
            title: response.cash.title,
            description: response.cash.description,
            isImageSquare: false
        )
        display.append(
            ProductSectionDisplay(
                title: I18n.General.digioCashTitle.text.setupText(
                    rangeString: "Cash", color: .lightGray, fontSize: 20),
                content: [cash]
            )
        )

        let products = response.products.map {
            ProductPreview(
                image: $0.imageURL,
                title: $0.name,
                description: $0.description,
                isImageSquare: true
            )
        }

        display.append(ProductSectionDisplay(
            title: NSAttributedString(
                string: I18n.General.productTitle.text),
                content: products
            )
        )

        return display
    }
}
