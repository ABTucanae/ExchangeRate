//
//  MockAPIClient.swift
//  ExchangeRateTests
//
//  Created by Alex on 28/11/2021.
//

import Foundation
@testable import ExchangeRate

class MockAPIClient: APIClientProtocol {

    var latestExchangeRate: LatestExchangeRate?

    func getLatestRates() async -> LatestExchangeRate? {
        return latestExchangeRate
    }
}
