//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by YaoKevinn on 24/12/2021.
//

import SwiftUI

struct XMarkButton: View {

    @Binding var showPortfolioView: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
                showPortfolioView.toggle()
            },
            label: { Image(systemName: "xmark").font(.headline) }
        )
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton(showPortfolioView: .constant(true))
    }
}
