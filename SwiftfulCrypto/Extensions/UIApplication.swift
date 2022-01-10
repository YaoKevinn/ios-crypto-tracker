//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by YaoKevinn on 23/12/2021.
//

import Foundation
import SwiftUI

extension UIApplication {

    // dismiss keyboard
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
