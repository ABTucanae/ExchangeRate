//
//  CurrencyComparisonViewModel.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

class CurrencyComparisonViewModel: ObservableObject {

    private let baseCurrencyValue: Double
    private let selectedCurrencies: Set<CurrencyCode>
    private let apiClient: APIClientProtocol

    init(baseCurrencyValue: Double, selectedCurrencies: Set<CurrencyCode>, apiClient: APIClientProtocol = APIClient()) {
        self.baseCurrencyValue = baseCurrencyValue
        self.selectedCurrencies = selectedCurrencies
        self.apiClient = apiClient
    }
}
