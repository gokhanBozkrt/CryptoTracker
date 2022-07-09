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

