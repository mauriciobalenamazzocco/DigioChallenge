//
//  ProductTableViewCell.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
import XCTest

@testable import DigioChallenge

class ProductTableViewCellTests: XCTestCase {

    // MARK: - Subject under test

    var sut: ProductTableViewCell!

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

    func setupSut() {
        sut = ProductTableViewCell()
    }

    // MARK: - Tests

    func test_numberOfItems_spotlight()
    {
        // Given
        guard let mock = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

        // When

        sut.setup(
            preview: ProductHelper.convertToSectionDisplay(
                response: mock)[ProductListViewSection.product.rawValue].content, delegate: nil)


        let items = sut.collectionView.numberOfItems(inSection: 0)

        // Then
        XCTAssertEqual(items, mock.products.count, "Number of Rows should be \(mock.products.count)")
    }
}
