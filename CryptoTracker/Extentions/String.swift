//
//  String.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 23.07.2022.
//

import Foundation

extension String {
    var removingHtmlOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
