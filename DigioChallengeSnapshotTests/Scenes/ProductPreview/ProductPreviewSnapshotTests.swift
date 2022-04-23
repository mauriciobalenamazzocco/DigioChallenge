//
//  ProductPreviewSnapshotTests.swift
//  DigioChallengeSnapshotTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//


import Foundation
import UIKit
import XCTest

@testable import DigioChallenge

class ProductPreviewSnapshotTests: SnapshotTests {

    // MARK: - Subject under test
    lazy var sut: ProductPreviewViewController = {
        var controller = ProductPreviewViewController()
        let model = ProductPreviewViewModel(productPreview: productPreviewMock, delegate: nil)
        controller.bind(to: model)
        return controller
    }()


    //MARK: - Mock

    let productPreviewMock = ProductPreview(
        image: "https://s3-sa-east-1.amazonaws.com/digio-exame/cash_banner.png",
        title: "digio Cash",
        description: "Dinheiro na conta sem complicação. Transfira parte do limite do seu cartão para sua conta.",
        isImageSquare: false
    )


    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        recordMode = false
    }

    // MARK: - Tests

    func testCCI() {

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
