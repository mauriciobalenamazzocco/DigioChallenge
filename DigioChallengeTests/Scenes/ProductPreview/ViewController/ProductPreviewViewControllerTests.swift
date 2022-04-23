//
//  ProductPreviewViewControllerTests.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation

import XCTest

@testable import DigioChallenge

class ProductPreviewViewControllerTests: XCTestCase
{
    // MARK: - Subject under test

    var sut: ProductPreviewViewController!

    // MARK: - Mock

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
        setupSut()
    }

    override func tearDown()
    {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupSut()
    {
        sut = ProductPreviewViewController()
        sut.bind(to: ProductPreviewViewModel(
            productPreview: productPreviewMock,
            delegate: nil)
        )
    }

    func test_stateShouldBeInitial() {

        // Given
        
        let expect = expectation(description: "wait return")

        //When

        var display: ProductPreview!

        sut.viewModel.state.bind { state in
            switch state {
            case let .initial(product):
                display = product
                expect.fulfill()
            default:
                break
            }
        }

        //Then

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(display, productPreviewMock, "Test State did fetch products")
    }
}
