//
//  CurrencyCode.swift
//  ExchangeRate
//
//  Created by Alex on 27/11/2021.
//

import Foundation

enum CurrencyCode: String {
    case eur
    case jpy
    case gbp
    case usd
    case aud
    case cad
    case chf
    case cny
    case sek
    case nzd

    static let baseCurrency = CurrencyCode.eur

    static let allowedCurrencies: [CurrencyCode] = [
        .jpy,
        .gbp,
        .usd,
        .aud,
        .cad,
        .chf,
        .cny,
        .sek,
        .nzd
    ]
}
