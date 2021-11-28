//
//  ToggleButton.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import SwiftUI

struct ToggleButton: View {

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

struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButton(value: .constant(false), enabledText: "Done", disabledText: "Edit")
    }
}
