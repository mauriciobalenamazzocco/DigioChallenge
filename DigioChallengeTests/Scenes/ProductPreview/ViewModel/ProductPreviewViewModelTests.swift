//
//  ProductPreviewViewModelTests.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
import XCTest

@testable import DigioChallenge

class ProductPreviewViewModelTests: XCTestCase {

    // MARK: - Subject under test

    var sut: ProductPreviewViewModelProtocol!

    //MARK: - Mock

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
        sut = ProductPreviewViewModel(
            productPreview: productPreviewMock,
            delegate: nil
        )
    }

    override func tearDown()
    {
        super.tearDown()
    }

    // MARK: - Test

    func test_stateShouldBeError() {

        // Given

        var stateTest: ProductPreviewViewModelState!

        let expect = expectation(description: "wait return")

        //When

        sut.state.bind { state in
            switch state {
            case .initial:
                stateTest = state
                expect.fulfill()
            default:
                break
            }
        }

        sut.preview()

        //Then
        
        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(stateTest, .initial(productPreviewMock), "Test State initial")
    }

}
