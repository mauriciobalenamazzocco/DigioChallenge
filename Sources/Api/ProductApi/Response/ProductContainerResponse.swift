//
//  ProductContainerResponse.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation

struct ProductContainerResponse: Codable, Equatable {
    let spotlight: [SpotlightModel]
    let products: [ProductModel]
    let cash: CashModel
}
