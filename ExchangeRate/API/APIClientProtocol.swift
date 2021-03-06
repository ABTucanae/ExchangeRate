//
//  APIClientProtocol.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

protocol APIClientProtocol {
    func getLatestRates() async -> LatestExchangeRates?
    func loadHistoricalRates(for date: Date, selectedCurrencies: [CurrencyCode]) async -> HistoricalRates?
}
