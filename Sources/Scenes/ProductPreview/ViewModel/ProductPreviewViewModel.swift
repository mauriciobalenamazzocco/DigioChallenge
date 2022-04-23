//
//  ProductPreviewViewModel.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 21/04/22.
//

import Foundation
protocol ProductPreviewViewModelProtocol: AnyObject {
    var state: Bindable<ProductPreviewViewModelState?> { get }
    func close()
    func preview()
}

protocol ProductPreviewViewModelDelegate: AnyObject {
    func close()
}

class ProductPreviewViewModel: ProductPreviewViewModelProtocol {

    // MARK: - Public Properties

    var state: Bindable<ProductPreviewViewModelState?> = Bindable(nil)

    // MARK: - Private Properties

    weak var delegate: ProductPreviewViewModelDelegate?
    private let productPreview: ProductPreview

    // MARK: - Constructors
    required init(productPreview: ProductPreview,
                  delegate: ProductPreviewViewModelDelegate? = nil) {
        self.productPreview = productPreview
        self.delegate = delegate
    }

    // MARK: - Methods

    func close() {
        delegate?.close()
    }

    func preview() {
        state.value = .initial(productPreview)
    }
}
