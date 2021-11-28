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
                        ForEach(viewModel.currencyPresentationObjects) { presentationObject in
                            ExchangeRateRow(
                                selectionEnabled: viewModel.selectionEnabled,
                                isSelected: viewModel.codeIsSelected(code: presentationObject.currencyCode),
                                presentationObject: presentationObject
                            )
                            .onTapGesture {
                                viewModel.selected(code: presentationObject.currencyCode)
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
                    Task {
                        await viewModel.loadExchangeRates()
                    }

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
