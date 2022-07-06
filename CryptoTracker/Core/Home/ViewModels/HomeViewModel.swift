//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 4.07.2022.
//

import Combine
import Foundation


class HomeViewModel: ObservableObject {
    @Published var allCoins : [Coin] = []
    @Published var portfolioCoins = [Coin]()
    
  
    private let dataService = CoinDataService()
    private var cancelables = Set<AnyCancellable>()
    init() {
    addSubscribers()
    // getPosts2()
    }
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.allCoins = returnedCoins
            }
            .store(in: &cancelables)
    }

}



/*
 func getPosts2() {
     guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
) else { return }
     downloadData(fromUrl: url) { data in
         if let data = data {
             guard let newPost = try? JSONDecoder().decode([Coin].self, from: data) else {
                 return
             }
             DispatchQueue.main.async { [weak self] in
                 self?.allCoins = newPost
                 
             }
         } else {
             print("No data")
         }
     }
 }
 func downloadData(fromUrl url: URL, completionHandler: @escaping (_ data: Data?) -> Void) {
     URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard let data = data,
               error == nil ,
               let response = response as? HTTPURLResponse,
               response.statusCode >= 200 && response.statusCode < 300 else {
             print("Unable to dpwnload data")
             completionHandler(nil)
             return
         }
   completionHandler(data)
         }.resume()
     }
 */
