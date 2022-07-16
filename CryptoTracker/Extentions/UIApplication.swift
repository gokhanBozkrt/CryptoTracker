//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 10.07.2022.
//

import Foundation
import SwiftUI
//MARK: To dissmis keyboard
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
