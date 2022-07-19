//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 19.07.2022.
//

import Combine
import Foundation

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancallables = Set<AnyCancellable>()
    init(coin: Coin) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { (returnedCoinDetails) in
                print("Received coin detail data")
                print(returnedCoinDetails)
            }
            .store(in: &cancallables)
        
    }
}
