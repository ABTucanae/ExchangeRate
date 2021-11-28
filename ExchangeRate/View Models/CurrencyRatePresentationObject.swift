//
//  CurrencyRatePresentationObject.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

struct CurrencyRatePresentationObject: Identifiable {
    let id = UUID()
    let currencyCode: CurrencyCode
    let title: String
    let amount: Double
}
