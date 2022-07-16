//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 9.07.2022.
//

import Combine
import Foundation
import SwiftUI

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    
    private var cancelables = Set<AnyCancellable>()
    private let coin: Coin
    private let dataService: CoinImageService
    
    init(coin: Coin) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] receivedImage in
                self?.image = receivedImage
            }
            .store(in: &cancelables)

    }
    
}
