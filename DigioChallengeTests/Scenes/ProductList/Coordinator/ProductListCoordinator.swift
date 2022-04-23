//
//  ProductListCoordinator.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
@testable import DigioChallenge
import XCTest

class ProductListCoordonatorTests: XCTestCase {

    // MARK: - Subject Under Test

    var coordinator: ProductListCoordinator!

    // MARK: - Spy

    var navigationControllerSpy: UINavigationControllerSpy!


    // MARK: - Tests Lifecycle

    override func setUp() {
        super.setUp()
        navigationControllerSpy = .init()

        coordinator = .init(
            navigationController: navigationControllerSpy,
            configuration: Configuration(enviroment: .virtual),
            delegate: nil)
    }

    // MARK: - Tests

    func testStart() {
        // When
        coordinator.start()

        // Then
        XCTAssert(navigationControllerSpy.pushViewControllerCalled,
                  "start should push to navigation controller")
        XCTAssert(navigationControllerSpy.viewController is ProductListViewController,
                  "start should push a feature view controller")
    }
}
