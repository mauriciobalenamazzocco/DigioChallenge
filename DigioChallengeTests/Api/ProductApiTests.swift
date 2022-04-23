//
//  ProductApiTests.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
import XCTest
@testable import DigioChallenge

class ProductApiTests: XCTestCase {

    // MARK: - Subject under test

    var productApiProtocol: ProductApiProtocol!

    // MARK: - Test lifecycle

    override func setUp()
    {
        super.setUp()
    }

    override func tearDown()
    {
        super.tearDown()
    }

    // MARK: - Test

    func test_ShouldReturnProductContainer()
    {
        // Given

        let urlSessionMock = URLSessionMock()
        urlSessionMock.data = ProductJsonMock.getJsonMock()
        urlSessionMock.urlResponse = HTTPURLResponse(
            url: URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/")!,
            statusCode: 200 ,
            httpVersion: "",
            headerFields: nil
        )

        // When

        productApiProtocol = ProductApi(
            domain: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/",
            session: urlSessionMock,
            authProvider: nil
        )

        var productContainer: ProductContainerResponse?

        let expect = expectation(description: "Wait for getProducts to return")

        productApiProtocol.getProducts { result in
            switch result {
            case .success(let container):
                productContainer = container
                expect.fulfill()
            case .failure( _): break
            }
        }

        waitForExpectations(timeout: 0.5)

        // Then

        XCTAssertEqual(productContainer?.spotlight.count, 2, "getProducts() should return a list of spotlight")
        XCTAssertEqual(productContainer?.products.count, 3, "getProducts() should return a list of products")
        XCTAssertNotNil(productContainer?.cash, "getProducts() should return a cash")
    }

    // MARK: - Test

    func test_ShouldReturnError()
    {
        // Given

        let urlSessionMock = URLSessionMock()
        urlSessionMock.error = NSError(domain: "Error", code: 404, userInfo: [:])

        // When

        productApiProtocol = ProductApi(
            domain: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/",
            session: urlSessionMock,
            authProvider: nil
        )

        var apiError: APIError?

        let expect = expectation(description: "Wait for getProducts to return")

        productApiProtocol.getProducts { result in
            switch result {
            case .success: break
            case let .failure( error):
                apiError = error
                expect.fulfill()
            }
        }

        waitForExpectations(timeout: 0.5)

        // Then

        XCTAssertNotNil(apiError, "getProducts() should return Api error")
    }
}
