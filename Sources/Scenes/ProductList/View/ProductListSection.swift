//
//  ProductListSection.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation

enum ProductListViewSection: Int {
    case spotlight
    case cash
    case product

    init?(indexPath: IndexPath) {
        self.init(rawValue: indexPath.section)
    }

    static var numberOfSections: Int { return 3 }
}
