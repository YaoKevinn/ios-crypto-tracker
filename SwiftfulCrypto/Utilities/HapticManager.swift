//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by YaoKevinn on 27/12/2021.
//

import Foundation
import UIKit

class HapticManager {
    static private let generator  = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
