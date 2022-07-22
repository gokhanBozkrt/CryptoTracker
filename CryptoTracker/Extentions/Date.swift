//
//  Date.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 22.07.2022.
//

import Foundation

extension Date {
    
    init(coinDateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinDateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
