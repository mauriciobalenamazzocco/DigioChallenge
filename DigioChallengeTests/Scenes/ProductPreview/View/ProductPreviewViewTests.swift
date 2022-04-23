//
//  ProductPreviewViewTests.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
import UIKit
import XCTest

@testable import DigioChallenge

class ProductPreviewViewTests: XCTestCase {

    // MARK: - Subject under test

    var sut: ProductPreviewView!

    // MARK: - Mock
    
    private var window: UIWindow!

    let productPreviewMock = ProductPreview(
        image: "https://s3-sa-east-1.amazonaws.com/digio-exame/cash_banner.png",
        title: "digio Cash",
        description: "Dinheiro na conta sem complicação. Transfira parte do limite do seu cartão para sua conta.",
        isImageSquare: false
    )

    // MARK: - Test lifecycle

    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupSut()
    }

    override func tearDown()
    {
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupSut() {
        sut = ProductPreviewView(frame: window.frame, delegate: nil)
    }

    // MARK: - Tests

    func test_FetchedRepositoriesIsLoading()
    {
        // Given
        // When

        sut.setup(display: productPreviewMock)

        // Then
        XCTAssertNotNil(sut.productPreview, "Product preview should not be nil")
    }
}
