//
//  ProductListViewModelTests.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
import XCTest

@testable import DigioChallenge

class ProductListViewModelTests: XCTestCase {

    // MARK: - Subject under test

    var productListViewModelProtocol: ProductListViewModelProtocol!

    // MARK: - Mock

    var apiMock: ProductApiMock!

    // MARK: - Test lifecycle

    override func setUp()
    {
        super.setUp()
        apiMock = ProductApiMock()
        productListViewModelProtocol = ProductListViewModel(
            productApi: apiMock,
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

        apiMock.response = .failure(APIError.businessError(message: "error"))

        //When

        var stateTest: ProductListViewModelState!

        let expect = expectation(description: "wait return")


        productListViewModelProtocol.state.bind { state in
            switch state {
            case .error:
                stateTest = state
                expect.fulfill()
            default:
                break
            }
        }

        productListViewModelProtocol.getProductList()

        //Then
        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(stateTest, .error("error"), "Test State Error")
    }

    func test_stateShouldBeSucess() {

        // Given

        guard let mock = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

        apiMock.response = .success(mock)

        //When

        var stateTest: ProductListViewModelState!


        let expect = expectation(description: "wait return")

        productListViewModelProtocol.state.bind { state in
            switch state {
            case .didFetch:
                stateTest = state
                expect.fulfill()
            default:
                break
            }
        }

        productListViewModelProtocol.getProductList()

        //Then

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(stateTest, .didFetch(ProductHelper.convertToSectionDisplay(response: mock)), "Test State did fetch products")
    }

    func test_stateShouldBeLoading() {

        // Given

        guard let mock = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

          apiMock.response = .success(mock)

        //When

        var stateTest: ProductListViewModelState!


        let expect = expectation(description: "wait return")


        productListViewModelProtocol.state.bind { state in
            switch state {
            case .loading:
                stateTest = state
                expect.fulfill()
            default:
                break
            }
        }

        productListViewModelProtocol.getProductList()

        //Then
        
        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(stateTest, .loading, "Test State did loading")
    }

}
