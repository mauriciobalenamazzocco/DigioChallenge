//
//  MainCoordinator.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation
import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func toProduct(preview: ProductPreview)
    func backToProduct()
}

class MainCoordinator {

    // MARK: - Properties
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []

    private var configuration: ConfigurationProtocol

    // MARK: - Constructors
    public init(navigationController: UINavigationController,
                configuration: ConfigurationProtocol
    ) {
        self.navigationController = navigationController
        self.configuration = configuration
    }
}

// MARK: - Start point
extension MainCoordinator: Coordinator {
    public func start() {
        let productListCoordinator = ProductListCoordinator(
            navigationController: navigationController,
            configuration: configuration,
            delegate: self)
        childCoordinators.append(productListCoordinator)
        productListCoordinator.start()
    }
}

extension MainCoordinator: MainCoordinatorDelegate {
    func backToProduct() {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: true)
        }
        childCoordinators.removeLast()
    }

    func toProduct(preview: ProductPreview) {
        let productPreview = ProductPreviewCoordinator(
            navigationController: navigationController,
            preview: preview,
            delegate: self)
        childCoordinators.append(productPreview)
        productPreview.start()
    }
}
