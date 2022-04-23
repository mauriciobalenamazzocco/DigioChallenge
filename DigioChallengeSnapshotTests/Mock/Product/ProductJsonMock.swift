//
//  ProductMock.swift
//  DigioChallengeSnapshotTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
@testable import DigioChallenge

class ProductJsonMock {

    static func getJsonMock() -> Data {
        let testBundle = Bundle(for: ProductJsonMock.self)
        guard let filePath = testBundle.path(forResource: "ProductJsonMock", ofType: "txt")
            else { fatalError() }
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        return jsonData
    }

    static func getProduct() -> ProductContainerResponse? {
        guard let product = try? JSONDecoder().decode(ProductContainerResponse.self, from: getJsonMock()) else {
            return nil
        }
        return product

    }
}
