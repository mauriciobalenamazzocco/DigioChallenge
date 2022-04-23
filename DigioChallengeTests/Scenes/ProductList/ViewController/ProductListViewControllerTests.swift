//
//  ProductListViewController.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
import XCTest

@testable import DigioChallenge

class ProductListViewControllerTests: XCTestCase
{
    // MARK: - Subject under test

    var sut: ProductListViewController!

    // MARK: - Mock

    var apiMock: ProductApiMock!


    // MARK: - Test lifecycle

    override func setUp()
    {
        super.setUp()
        setupProductListViewController()
    }

    override func tearDown()
    {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupProductListViewController()
    {
        sut = ProductListViewController()
        apiMock = ProductApiMock()
    }


    func test_stateShouldBeSucess() {

        // Given

        guard let mock = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

        apiMock.response = .success(mock)

        sut.bind(to: ProductListViewModel(
            productApi: apiMock,
            delegate: nil)
        )

        //When

        var display: [ProductSectionDisplay] = []


        let expect = expectation(description: "wait return")

        sut.viewModel.state.bind { state in
            switch state {
            case let .didFetch(arr):
                display = arr
                expect.fulfill()
            default:
                break
            }
        }

        //Then

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(display, ProductHelper.convertToSectionDisplay(response: mock), "Test State did fetch products")
    }


    func test_stateShouldBeError() {

        // Given

        apiMock.response = .failure(APIError.businessError(message: "error"))

        sut.bind(to: ProductListViewModel(
            productApi: apiMock,
            delegate: nil)
        )

        //When

        var error: String = ""

        let expect = expectation(description: "wait return")

        sut.viewModel.state.bind { state in
            switch state {
            case let .error(err):
                error = err
                expect.fulfill()
            default:
                break
            }
        }

        //Then
        
        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(error, "error", "Test State did fetch products")
    }
}
