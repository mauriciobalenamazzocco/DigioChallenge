//
//  ProductListViewTests.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation
import XCTest

@testable import DigioChallenge

class ProductListViewTests: XCTestCase {

    // MARK: - Subject under test

    var sut: ProductListView!

    // MARK: - Mock

    var window: UIWindow!

    // MARK: - Mock

    class TableViewSpy: UITableView
    {
        // MARK: Method call expectations

        var reloadDataCalled = false
        var reloadCount = 0

        // MARK: Spied methods

        override func reloadData()
        {
            reloadCount = reloadCount + 1
            reloadDataCalled = true
        }
    }

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
        sut = ProductListView(frame: window.frame, delegate: nil)
    }

    // MARK: - Tests

    func test_TableReloadDataCalled()
    {
        // Given
        guard let mock = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

        let tableViewSpy = TableViewSpy()

        sut.tableView = tableViewSpy

        // When
        sut.setup(display: ProductHelper.convertToSectionDisplay(response: mock))

        // Then
        XCTAssertEqual(tableViewSpy.reloadCount, 1)
    }

    func test_NumberOfSections()
    {
        // Given

        let tableView = sut.tableView

        guard let mock = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

        // When

        sut.setup(display: ProductHelper.convertToSectionDisplay(response: mock))
        let numberOfSections = sut.numberOfSections(in: tableView)

        // Then
        XCTAssertEqual(numberOfSections, ProductListViewSection.numberOfSections, "The number of table view sections should always be 3")
    }

    func test_HeaderInSectionSpotLight()
    {
        // Given

        let tableView = sut.tableView

        guard let mock = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

        // When

        sut.setup(display: ProductHelper.convertToSectionDisplay(response: mock))
        let headerInsection = sut.tableView(tableView, viewForHeaderInSection: ProductListViewSection.spotlight.rawValue)

        // Then

        XCTAssertNil(headerInsection, "The header SpotLight should be nil")
    }

    func test_HeaderInSectionCash()
    {
        // Given

        let tableView = sut.tableView

        guard let mock = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

        // When

        sut.setup(display: ProductHelper.convertToSectionDisplay(response: mock))

        let headerInsection = sut.tableView(tableView, viewForHeaderInSection: ProductListViewSection.cash.rawValue)

        // Then

        XCTAssertNotNil(headerInsection, "The header Cash should be not nil")
    }

    func test_HeaderInSectionProduct()
    {
        // Given

        let tableView = sut.tableView

        guard let mock = ProductJsonMock.getProduct() else {
            XCTFail()
            return
        }

        // When

        sut.setup(display: ProductHelper.convertToSectionDisplay(response: mock))

        let headerInsection = sut.tableView(tableView, viewForHeaderInSection: ProductListViewSection.product.rawValue)

        // Then

        XCTAssertNotNil(headerInsection, "The first header Product should be not nil")
    }
}
