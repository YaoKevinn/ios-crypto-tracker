//
//  String.swift
//  SwiftfulCrypto
//
//  Created by YaoKevinn on 28/12/2021.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
