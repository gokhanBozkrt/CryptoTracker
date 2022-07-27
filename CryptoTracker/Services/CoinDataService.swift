//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 5.07.2022.
//
import Combine
import Foundation


class CoinDataService {
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    init() {
        getCoins()
    }
    
     func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        ) else { return }
        
        coinSubscription =  NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.completionHandler, receiveValue: { [weak self] (receivedCoins) in
                self?.allCoins = receivedCoins
                self?.coinSubscription?.cancel()
            })
    }
}



