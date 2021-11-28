//
//  CurrencyLookupViewModel.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation
import SwiftUI

class CurrencyLookupViewModel: ObservableObject {

    @Published var currencyPresentationObjects = [CurrencyRatePresentationObject]()
    @Published var selectionEnabled = false
    @Published var navigateToComparison = false
    @Published var selectedCurrencies = Set<CurrencyCode>() {
        didSet {
            navigateToComparison = selectedCurrencies.count == 2
        }
    }

    @Published var baseCurrencyValue = 0.0 {
        didSet {
            if let exchangeRates = exchangeRates {
                currencyPresentationObjects = createCurrencyPresentationObjects(using: exchangeRates.rates)
            }
        }
    }

    private let apiClient: APIClientProtocol
    private var exchangeRates: LatestExchangeRate?

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

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

    func loadExchangeRates() async {
        guard let latestExchangeRates = await apiClient.getLatestRates() else { return }

        exchangeRates = latestExchangeRates

        await MainActor.run {
            currencyPresentationObjects = createCurrencyPresentationObjects(using: latestExchangeRates.rates)
        }
    }

    func createCurrencyPresentationObjects(using exchangeRates: [String: Double]) -> [CurrencyRatePresentationObject] {
        return CurrencyCode.allowedCurrencies.compactMap { code in
            let formattedCurrencyCode = formatted(code: code)

            guard let exchangeRate = exchangeRates[formattedCurrencyCode] else { return nil }

            let amount = baseCurrencyValue * exchangeRate

            return CurrencyRatePresentationObject(currencyCode: code, title:formattedCurrencyCode, amount: amount)
        }
    }
}
