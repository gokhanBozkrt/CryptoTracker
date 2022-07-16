//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 15.07.2022.
//

import Foundation
import SwiftUI


class HapticManager {
   static  private let generator = UINotificationFeedbackGenerator()
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
        
    }
}
