//
//  ExchangeRateApp.swift
//  ExchangeRate
//
//  Created by Alex on 27/11/2021.
//

import SwiftUI

@main
struct ExchangeRateApp: App {
    @StateObject private var currencyLookupViewModel = CurrencyLookupViewModel()

    var body: some Scene {
        WindowGroup {
            CurrencyLookupView(viewModel: currencyLookupViewModel)
        }
    }
}
