//
//  MainCoordinator.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation
import UIKit

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
            configuration: configuration
        )
        childCoordinators.append(productListCoordinator)
        productListCoordinator.start()
    }
}
