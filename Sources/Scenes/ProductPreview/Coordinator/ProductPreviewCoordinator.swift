//
//  ProductPreviewCoordinator.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation
import UIKit

protocol ProductPreviewCoordinatorDelegate: AnyObject {
    func popToList()
}

class ProductPreviewCoordinator {

    // MARK: - Properties
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []

    private weak var delegate: ProductPreviewCoordinatorDelegate?

    private let preview: ProductPreview

    // MARK: - Constructors
    public init(navigationController: UINavigationController,
                preview: ProductPreview,
                delegate: ProductPreviewCoordinatorDelegate?
    ) {
        self.navigationController = navigationController
        self.preview = preview
        self.delegate = delegate
    }
}

// MARK: - Start point
extension ProductPreviewCoordinator: Coordinator {
    public func start() {
        var viewController = ProductPreviewViewController()
        let productPeviewModel = ProductPreviewViewModel(productPreview: preview, delegate: self)
        viewController.bind(to: productPeviewModel)

        navigationController.present(viewController, animated: true)
    }
}

extension ProductPreviewCoordinator: ProductPreviewViewModelDelegate {
    func close() {
        delegate?.popToList()
    }
}
