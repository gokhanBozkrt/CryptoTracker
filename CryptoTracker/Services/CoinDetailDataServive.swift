//
//  CoinDetailDataServive.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 19.07.2022.
//

import Combine
import Foundation


class CoinDetailDataService {
    @Published var coinDetails: CoinDetail? = nil
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
     func getCoinDetails() {
         guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        ) else { return }
        
         coinDetailSubscription =  NetworkingManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.completionHandler, receiveValue: { [weak self] (receivedCoinDetails) in
                self?.coinDetails = receivedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
