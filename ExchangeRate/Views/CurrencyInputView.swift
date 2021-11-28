//
//  CurrencyInputView.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import SwiftUI

struct CurrencyInputView: View {

    @FocusState private var isFocused: Bool
    @Binding var baseCurrencyValue: Double

    var currencyCode: CurrencyCode

    var body: some View {
        VStack {
            HStack {
                Text(currencyCode.rawValue.uppercased())

                TextField(
                    "Enter Amount",
                    value: $baseCurrencyValue,
                    format: .number // I would have liked to have used the currency formatter here, but I experienced a bug with the bound value not being updated because the text field contains a currency symbol.
                )
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .focused($isFocused)
            }

            if isFocused {
                Button("Dismiss Keyboard") {
                    isFocused = false
                }
            }
        }

    }
}

struct CurrencyInputView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyInputView(baseCurrencyValue: .constant(1341), currencyCode: .jpy)
    }
}
