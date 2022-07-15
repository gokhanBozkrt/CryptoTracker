//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 12.07.2022.
//

import Combine
import Foundation


class MarketDataService {
    @Published var marketData: MarketData? = nil
    
    var marketDataSubscription: AnyCancellable?
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription =  NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.completionHandler, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}

