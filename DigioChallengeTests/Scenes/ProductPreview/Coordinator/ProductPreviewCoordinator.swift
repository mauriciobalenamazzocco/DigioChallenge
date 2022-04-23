//
//  ProductPreviewCoordinator.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation

@testable import DigioChallenge
import XCTest

class ProductPreviewCoordonatorTests: XCTestCase {

    // MARK: - Subject Under Test

    var coordinator: ProductPreviewCoordinator!

    // MARK: - Spy

    var navigationControllerSpy: UINavigationControllerSpy!

    // MARK: - Mock

    let productPreview = ProductPreview(
        image: "",
        title: "",
        description: "",
        isImageSquare: false
    )


    // MARK: - Tests Lifecycle

    override func setUp() {
        super.setUp()
        navigationControllerSpy = .init()

        coordinator = .init(
            navigationController: navigationControllerSpy,
            preview: productPreview,
            delegate: nil)
    }

    // MARK: - Tests

    func testStart() {
        // When
        coordinator.start()

        // Then
        XCTAssert(navigationControllerSpy.presentCalled,
                  "start should push to navigation controller")
        XCTAssert(navigationControllerSpy.viewController is ProductPreviewViewController,
                  "start should push a feature view controller")
    }
}
