//
//  LatestExchangeRate.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

struct LatestExchangeRate: Decodable {
    let timestamp: Date
    let base: String
    let date: String
    let rates: [String: Double]
}
