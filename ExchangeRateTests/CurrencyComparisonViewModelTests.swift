//
//  CurrencyComparisonViewModelTests.swift
//  ExchangeRateTests
//
//  Created by Alex on 29/11/2021.
//

import XCTest
@testable import ExchangeRate

class CurrencyComparisonViewModelTests: XCTestCase {

    var viewModel: CurrencyComparisonViewModel!
    var mockAPIClient: MockAPIClient!

    override func setUpWithError() throws {
        mockAPIClient = MockAPIClient()
        viewModel = CurrencyComparisonViewModel(baseCurrencyValue: 1, selectedCurrencies: [.jpy, .gbp], apiClient: mockAPIClient)
    }

    func testFirstCurrencyTitle() {
        XCTAssertEqual(viewModel.firstCurrencyTitle, "JPY")
    }

    func testSecondCurrencyTitle() {
        XCTAssertEqual(viewModel.secondCurrencyTitle, "GBP")
    }

    func testCreateHistoricalPresentationObjects() {
        let historicalRates: [HistoricalRates] = [
            .init(date: "2021-1-1", rates: ["JPY": 99, "GBP": 1.4]),
            .init(date: "2021-1-2", rates: ["JPY": 50, "GBP": 20.5])
        ]
        let presentationObjects = viewModel.createHistoricalPresentationObjects(for: historicalRates)

        XCTAssertEqual(presentationObjects.count, 2)

        XCTAssertEqual(presentationObjects[0].date, "2021-1-2")
        XCTAssertEqual(presentationObjects[0].firstCurrency, .jpy)
        XCTAssertEqual(presentationObjects[0].firstCurrencyValue, 50)
        XCTAssertEqual(presentationObjects[0].secondCurrency, .gbp)
        XCTAssertEqual(presentationObjects[0].secondCurrencyValue, 20.5)

        XCTAssertEqual(presentationObjects[1].date, "2021-1-1")
        XCTAssertEqual(presentationObjects[1].firstCurrency, .jpy)
        XCTAssertEqual(presentationObjects[1].firstCurrencyValue, 99)
        XCTAssertEqual(presentationObjects[1].secondCurrency, .gbp)
        XCTAssertEqual(presentationObjects[1].secondCurrencyValue, 1.4)
    }

    func testLoadHistoricalRates() async {
        let expectedRate = HistoricalRates(date: "2021-1-1", rates: ["JPY": 100, "GBP": 1.5])
        mockAPIClient.historicalRates = expectedRate

        await viewModel.loadHistoricalRates()

        XCTAssertEqual(viewModel.historicalRatesPresentationObjects.count, 5)
    }
}
