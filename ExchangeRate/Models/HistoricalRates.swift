//
//  HistoricalRates.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

struct HistoricalRates: Decodable {
    let date: String
    let rates: [String: Double]
}
