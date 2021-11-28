//
//  CurrencyLookupView.swift
//  ExchangeRate
//
//  Created by Alex on 27/11/2021.
//

import SwiftUI

struct CurrencyLookupView: View {
    @ObservedObject var viewModel: CurrencyLookupViewModel

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Second screen"), isActive: $viewModel.navigateToComparison) { EmptyView() }

                List {
                    Section(header: Text("Enter Amount:")) {
                        CurrencyInputView(baseCurrencyValue: $viewModel.baseCurrencyValue, currencyCode: .baseCurrency)
                    }

                    Section(
                        header: Text("Exchange Rate Results:"),
                        footer: Text(viewModel.selectionEnabled ? "Select 2 currencies to compare" : "")
                    ) {
                        ForEach(CurrencyCode.allowedCurrencies, id: \.self) { code in
                            ExchangeRateRow(
                                selectionEnabled: viewModel.selectionEnabled,
                                isSelected: viewModel.codeIsSelected(code: code),
                                currencyCode: viewModel.formatted(code: code),
                                amount: 0.0
                            )
                            .onTapGesture {
                                viewModel.selected(code: code)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Exchange Rate")
                .toolbar {
                    ToggleButton(value: $viewModel.selectionEnabled, enabledText: "Done", disabledText: "Compare")
                }
                .onAppear {
                    viewModel.resetSelectedState()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyLookupView(viewModel: CurrencyLookupViewModel())
    }
}
