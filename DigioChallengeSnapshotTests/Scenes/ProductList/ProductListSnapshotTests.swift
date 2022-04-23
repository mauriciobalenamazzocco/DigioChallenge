//
//  ProductListSnapshotTests.swift
//  DigioChallengeSnapshotTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
import UIKit
import XCTest

@testable import DigioChallenge

class ProductListSnapshotTests: SnapshotTests {

    // MARK: - Subject under test
    lazy var sut: ProductListViewController = {
        var controller = ProductListViewController()
        let model = ProductListViewModel(productApi: apiMock, delegate: nil)
        controller.bind(to: model)
        return controller
    }()


    //MARK: - Mock

    let apiMock = ProductApiMock()

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        recordMode = false
    }

    // MARK: - Tests

    func testCCI() {
        guard let response = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

        apiMock.response = .success(response)
        sut.viewWillAppear(true)
        verify()
    }

    private func verify() {
        sut.loadForSnapshot()
        sleepTest(for: 2)

        self.verifySnapshotView { () -> UIView? in
            return self.sut.view
        }
    }
}
