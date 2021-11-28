//
//  ExchangeRateRow.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import SwiftUI

struct ExchangeRateRow: View {

    var selectionEnabled: Bool
    var isSelected: Bool
    var currencyCode: String
    var amount: Double

    var body: some View {
        HStack {
            if selectionEnabled {
                Image(systemName: isSelected ? "checkmark.circle" : "circle")
            }

            Text(currencyCode)

            Spacer()

            Text(amount, format: .currency(code: currencyCode))
        }
    }
}

struct ExchangeRateRow_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateRow(selectionEnabled: true, isSelected: true, currencyCode: "USD", amount: 91919)
    }
}

