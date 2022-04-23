//
//  MainCoordonatorTests.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
import XCTest

@testable import DigioChallenge

class MainCoordonatorTests: XCTestCase {

    // MARK: - Subject Under Test
    var coordinator: MainCoordinator!

    // MARK: - Spy
    var navigationControllerSpy: UINavigationControllerSpy!

    // MARK: - Tests Lifecycle

    override func setUp() {
        super.setUp()
        navigationControllerSpy = .init()
        coordinator = .init(
            navigationController: navigationControllerSpy,
            configuration: Configuration(enviroment: .virtual)
        )
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
        XCTAssertEqual(coordinator.childCoordinators.count,
                       1,
                       "start() should set only 1 child coordinator")
        XCTAssert(coordinator.childCoordinators[0] is ProductListCoordinator,
                  "start should init with scene coordinator")
    }
}
