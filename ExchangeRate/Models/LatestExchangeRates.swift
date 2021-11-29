//
//  LatestExchangeRates.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

struct LatestExchangeRates: Decodable {
    let rates: [String: Double]
}
