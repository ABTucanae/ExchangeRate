//
//  CurrencyComparisonRow.swift
//  ExchangeRate
//
//  Created by Alex on 29/11/2021.
//

import SwiftUI

struct CurrencyComparisonRow: View {
    var presentationObject: HistoricalRatesPresentationObject

    var body: some View {
        HStack {
            Text(presentationObject.date)
            
            Spacer()

            Text(presentationObject.firstCurrencyValue, format: .currency(code: presentationObject.firstCurrency.rawValue))

            Spacer()

            Text(presentationObject.secondCurrencyValue, format: .currency(code: presentationObject.secondCurrency.rawValue))
        }
    }
}

struct CurrencyComparisonRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyComparisonRow(presentationObject: .init(date: "2020-07-01", firstCurrencyValue: 100, secondCurrencyValue: 200, firstCurrency: .eur, secondCurrency: .jpy))
    }
}
