//
//  HistoricalRatesPresentationObject.swift
//  ExchangeRate
//
//  Created by Alex on 29/11/2021.
//

import Foundation

struct HistoricalRatesPresentationObject: Identifiable {
    let id = UUID()

    let date: String

    let firstCurrencyValue: Double
    let secondCurrencyValue: Double

    let firstCurrency: CurrencyCode
    let secondCurrency: CurrencyCode
}
