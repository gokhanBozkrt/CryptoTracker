//
//  Color.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 27.06.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}


struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryTextColor = Color("SecondaryTextColor")
}

struct LaunchTheme {
    let background = Color("LaunchBackGroundColor")
    let accent = Color("LaunchAccentColor")
}
