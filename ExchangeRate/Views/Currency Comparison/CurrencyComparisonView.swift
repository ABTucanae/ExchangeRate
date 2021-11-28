//
//  CurrencyComparisonView.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import SwiftUI

struct CurrencyComparisonView: View {

    @ObservedObject var viewModel: CurrencyComparisonViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CurrencyComparisonView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyComparisonView(viewModel: .init(baseCurrencyValue: 100, selectedCurrencies: [.gbp, .jpy]))
    }
}
