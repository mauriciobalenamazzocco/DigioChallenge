//
//  ProductListViewModelState.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation

enum ProductListViewModelState: Equatable {
    case loading
    case error(String)
    case didFetch([ProductSectionDisplay])

}
