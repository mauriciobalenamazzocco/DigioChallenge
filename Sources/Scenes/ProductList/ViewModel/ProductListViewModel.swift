//
//  ProductListViewModel.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation
import UIKit

protocol ProductListViewModelDelegate: AnyObject {
    func toPreview(product: ProductPreview)
}
protocol ProductListViewModelProtocol: AnyObject {
    var state: Bindable<ProductListViewModelState?> { get }
    func getProductList()
    func goToDigioPage()
    func toPreview(product: ProductPreview)
}

class ProductListViewModel: ProductListViewModelProtocol {

    // MARK: - Public Properties

    var state: Bindable<ProductListViewModelState?> = Bindable(nil)

    // MARK: - Private Properties

    private var productContainerResponse: ProductContainerResponse?
    private var productApi: ProductApiProtocol
    private weak var delegate: ProductListViewModelDelegate?

    // MARK: - Constructors

    required init(productApi: ProductApiProtocol,
                  delegate: ProductListViewModelDelegate?
    ) {
        self.delegate = delegate
        self.productApi = productApi
    }

    // MARK: - Methods

    func getProductList() {
        state.value = .loading

        productApi.getProducts { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {

                switch response {

                case let .success(productContainerResponse):
                    self.state.value = .didFetch(
                        self.convertResponseToDisplay(
                            response: productContainerResponse
                        )
                    )

                case let .failure(apiErrorResponse):
                    self.state.value = .error(apiErrorResponse.description)
                }
            }
        }
    }

    func goToDigioPage() {

        guard let url = URL(string: Constant.digioPageUrl) else { return }
        UIApplication.shared.open(
            url, options: [:],
            completionHandler: nil
        )

    }

    func toPreview(product: ProductPreview) {
        delegate?.toPreview(product: product)
    }

    private func convertResponseToDisplay(response: ProductContainerResponse) -> [ProductSectionDisplay] {
        return ProductHelper.convertToSectionDisplay(response: response)
    }
}
