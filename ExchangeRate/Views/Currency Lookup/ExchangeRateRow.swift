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
    var presentationObject: CurrencyRatePresentationObject

    var body: some View {
        HStack {
            if selectionEnabled {
                Image(systemName: isSelected ? "checkmark.circle" : "circle")
            }

            Text(presentationObject.title)

            Spacer()

            Text(presentationObject.amount, format: .currency(code: presentationObject.currencyCode.rawValue))
        }
    }
}

struct ExchangeRateRow_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateRow(selectionEnabled: true, isSelected: true, presentationObject: .init(currencyCode: .gbp, title: "£", amount: 100))
    }
}

