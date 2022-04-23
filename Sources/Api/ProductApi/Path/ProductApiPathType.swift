//
//  ProductServicePathType.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation

enum ProductApiPathType: String, CaseIterable {
    case products = "sandbox/products"

    func path() -> String {
        return self.rawValue
    }
}
