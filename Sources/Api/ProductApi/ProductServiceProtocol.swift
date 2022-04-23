//
//  ProductApiProtocol.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation

protocol ProductApiProtocol {
    typealias CompletionProductContainer = (Either<ProductContainerResponse>) -> Void

    func getProducts(completion: @escaping CompletionProductContainer)
}
