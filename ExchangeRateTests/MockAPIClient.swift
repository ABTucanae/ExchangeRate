//
//  MockAPIClient.swift
//  ExchangeRateTests
//
//  Created by Alex on 28/11/2021.
//

import Foundation
@testable import ExchangeRate

class MockAPIClient: APIClientProtocol {

    var latestExchangeRates: LatestExchangeRates?

    func getLatestRates() async -> LatestExchangeRates? {
        return latestExchangeRates
    }

    var historicalRates: HistoricalRates?

    func loadHistoricalRates(for date: Date, selectedCurrencies: [CurrencyCode]) async -> HistoricalRates? {
        return historicalRates
    }
}
