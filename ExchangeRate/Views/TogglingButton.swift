//
//  TogglingButton.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import SwiftUI

struct TogglingButton: View {

    @Binding var value: Bool
    var enabledText: String
    var disabledText: String

    var body: some View {
        Button {
            value.toggle()
        } label: {
            Text(value ? enabledText : disabledText)
        }
    }
}

struct TogglingButton_Previews: PreviewProvider {
    static var previews: some View {
        TogglingButton(value: .constant(false), enabledText: "Done", disabledText: "Edit")
    }
}
