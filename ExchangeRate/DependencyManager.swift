//
//  DependencyManager.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

class DependencyManager: ObservableObject {

    let apiClient = APIClient()

    func constructInitialViewModel() -> CurrencyLookupViewModel {
        CurrencyLookupViewModel(apiClient: apiClient)
    }

    func constructNextViewModel(from lookupViewModel: CurrencyLookupViewModel) -> CurrencyComparisonViewModel {
        CurrencyComparisonViewModel(baseCurrencyValue: lookupViewModel.baseCurrencyValue, selectedCurrencies: lookupViewModel.selectedCurrencies, apiClient: apiClient)
    }
}
