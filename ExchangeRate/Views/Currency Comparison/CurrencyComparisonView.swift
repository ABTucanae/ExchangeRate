//
//  CurrencyComparisonView.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import SwiftUI

struct CurrencyComparisonView: View {

    @StateObject var viewModel: CurrencyComparisonViewModel

    var body: some View {
        List {
            Section(header: Text("Base currency")) {
                Text(viewModel.baseCurrencyValue, format: .currency(code: CurrencyCode.baseCurrency.rawValue))
            }

            Section(header: Text("5 Day Comparison")) {
                ForEach(viewModel.historicalRatesPresentationObjects) { presentationObject in
                    CurrencyComparisonRow(presentationObject: presentationObject)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Compare")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.loadHistoricalRates()
            }
        }
    }
}

struct CurrencyComparisonView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyComparisonView(viewModel: .init(baseCurrencyValue: 100, selectedCurrencies: [.gbp, .jpy]))
    }
}
