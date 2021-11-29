//
//  CurrencyLookupViewModelTests.swift
//  ExchangeRateTests
//
//  Created by Alex on 28/11/2021.
//

import XCTest
@testable import ExchangeRate

class CurrencyLookupViewModelTests: XCTestCase {

    var viewModel: CurrencyLookupViewModel!
    var mockAPIClient: MockAPIClient!

    override func setUpWithError() throws {
        mockAPIClient = MockAPIClient()
        viewModel = CurrencyLookupViewModel(apiClient: mockAPIClient)
    }

    func testSelected_AddCode() {
        XCTAssertTrue(viewModel.selectedCurrencies.isEmpty)

        viewModel.selected(code: .jpy)

        XCTAssertEqual(viewModel.selectedCurrencies, Set([CurrencyCode.jpy]))
    }

    func testSelected_RemoveCode() {
        XCTAssertTrue(viewModel.selectedCurrencies.isEmpty)

        viewModel.selected(code: .eur)

        XCTAssertEqual(viewModel.selectedCurrencies, Set([CurrencyCode.eur]))

        viewModel.selected(code: .eur)

        XCTAssertTrue(viewModel.selectedCurrencies.isEmpty)
    }

    func testSelected_MaxSelectionReached() {
        XCTAssertTrue(viewModel.selectedCurrencies.isEmpty)

        viewModel.selected(code: .jpy)
        viewModel.selected(code: .gbp)

        XCTAssertEqual(viewModel.selectedCurrencies, Set([CurrencyCode.jpy, .gbp]))

        viewModel.selected(code: .usd)

        XCTAssertEqual(viewModel.selectedCurrencies, Set([CurrencyCode.jpy, .gbp]))
    }

    func testNavigationToComparison_EnabledAfterTwoSelectedCountries() {
        XCTAssertFalse(viewModel.navigateToComparison)

        viewModel.selected(code: .jpy)
        viewModel.selected(code: .gbp)

        XCTAssertTrue(viewModel.navigateToComparison)
    }

    func testCodeIsSelected_True() {
        viewModel.selected(code: .gbp)

        XCTAssertTrue(viewModel.codeIsSelected(code: .gbp))
    }

    func testCodeIsSelected_False() {
        viewModel.selected(code: .aud)

        XCTAssertFalse(viewModel.codeIsSelected(code: .gbp))
    }

    func testFormattedCode() {
        XCTAssertEqual(viewModel.formatted(code: .baseCurrency), CurrencyCode.baseCurrency.rawValue.uppercased())
    }

    func testResetSelectedState() {
        viewModel.selected(code: .jpy)
        viewModel.selectionEnabled = true

        XCTAssertEqual(viewModel.selectedCurrencies, Set([CurrencyCode.jpy]))

        viewModel.resetSelectedState()

        XCTAssertTrue(viewModel.selectedCurrencies.isEmpty)
        XCTAssertFalse(viewModel.selectionEnabled)
    }

    func testLoadExchangeRates_CreatesCurrencyPresentationObjectsBasedOnResponse() async {
        let expectedDto = LatestExchangeRates(rates: ["USD": 1.1])
        
        mockAPIClient.latestExchangeRates = expectedDto
        viewModel.baseCurrencyValue = 1
        await viewModel.loadExchangeRates()

        XCTAssertEqual(viewModel.currencyPresentationObjects.count, 1)
        XCTAssertEqual(viewModel.currencyPresentationObjects[0].amount, 1.1)
        XCTAssertEqual(viewModel.currencyPresentationObjects[0].title, "USD")
        XCTAssertEqual(viewModel.currencyPresentationObjects[0].currencyCode, .usd)
    }

    func testCreateCurrencyPresentationObjects() {
        viewModel.baseCurrencyValue = 2

        let pos = viewModel.createCurrencyPresentationObjects(using: ["GBP": 100])

        XCTAssertEqual(pos.count, 1)
        XCTAssertEqual(pos[0].amount, 200)
        XCTAssertEqual(pos[0].title, "GBP")
        XCTAssertEqual(pos[0].currencyCode, .gbp)
    }
}
