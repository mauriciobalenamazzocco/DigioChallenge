//
//  ProductListCoordinator.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation

import UIKit

class ProductListCoordinator {

    // MARK: - Properties

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []

    private var configuration: ConfigurationProtocol
    private weak var delegate: MainCoordinatorDelegate?

    // MARK: - Constructors

    public init(navigationController: UINavigationController,
                configuration: ConfigurationProtocol,
                delegate: MainCoordinatorDelegate?
    ) {
        self.navigationController = navigationController
        self.configuration = configuration
        self.delegate = delegate
    }
}

// MARK: - Start point

extension ProductListCoordinator: Coordinator {
    public func start() {
        var viewController = ProductListViewController()
        let api = ProductApi(domain: configuration.enviroment.basePath)
        viewController.bind(to: ProductListViewModel(productApi: api, delegate: self))
        navigationController.pushViewController(viewController, animated: false)
    }
}

// MARK: - ProductListViewModelDelegate

extension ProductListCoordinator: ProductListViewModelDelegate {
    func toPreview(product: ProductPreview) {
        delegate?.toProduct(preview: product)
    }
}
