//
//  CurrencyLookupViewModel.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

class CurrencyLookupViewModel: ObservableObject {

    @Published var baseCurrencyValue = 0.0
    @Published var selectedCurrencies = Set<CurrencyCode>() {
        didSet {
            navigateToComparison = selectedCurrencies.count == 2
        }
    }

    @Published var selectionEnabled = false
    @Published var navigateToComparison = false

    func codeIsSelected(code: CurrencyCode) -> Bool {
        selectedCurrencies.contains(code)
    }

    func selected(code: CurrencyCode) {
        if selectedCurrencies.contains(code) {
           selectedCurrencies.remove(code)
        } else if selectedCurrencies.count < 2 {
            selectedCurrencies.insert(code)
        }
    }

    func formatted(code: CurrencyCode) -> String {
        code.rawValue.uppercased()
    }

    func resetSelectedState() {
        selectedCurrencies.removeAll(keepingCapacity: true)
        selectionEnabled = false
    }
}
