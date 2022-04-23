//
//  ProductApi.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation

class ProductApi: Api {
    var session: URLSessionProtocol
    var domain: String
    var authProvider: AuthenticationHeaderProvider?

    required init(domain: String,
                  session: URLSessionProtocol = URLSession.shared,
                  authProvider: AuthenticationHeaderProvider? = nil) {
        self.domain = domain
        self.session = session
        self.authProvider = authProvider
    }
}

extension ProductApi: ProductApiProtocol {
    func getProducts(completion: @escaping CompletionProductContainer) {
        let req = Request(
            domain: self.domain,
            path: ProductApiPathType.products.path(),
            method: .get
        )

        resumeToEntity(
            req: req,
            completion: completion
        )
    }
}
