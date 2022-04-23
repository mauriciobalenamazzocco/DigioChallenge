//
//  ProductApiMock.swift
//  DigioChallengeSnapshotTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
@testable import DigioChallenge

class ProductApiMock: ProductApiProtocol {
    var response: Either<ProductContainerResponse>!

    func getProducts(completion: @escaping CompletionProductContainer) {
        return completion(response)
    }
}
