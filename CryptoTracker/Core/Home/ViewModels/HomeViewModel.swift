//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 4.07.2022.
//

import Combine
import Foundation


class HomeViewModel: ObservableObject {
  
    @Published var statistics : [Statistic] = [
        Statistic(title: "Title", value: "Value", percentageChange: 1),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value", percentageChange: -2)
        ]
    @Published var allCoins : [Coin] = []
    @Published var portfolioCoins = [Coin]()
    @Published var searchText = ""
  
    private let dataService = CoinDataService()
    private var cancelables = Set<AnyCancellable>()
    init() {
    addSubscribers()
    // getPosts2()
    }
    func addSubscribers() {
       // dataService.$allCoins
//            .sink { [weak self] (returnedCoins) in
//                guard let self = self else { return }
//                self.allCoins = returnedCoins
//            }
//            .store(in: &cancelables)
        //MARK: Updates allcoins
            $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filteredCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
    }
    private func filteredCoins(text:String,startingCoins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
                return startingCoins
            }
            let lowerCasedText = text.lowercased()
        return startingCoins.filter {
                return $0.name.lowercased().contains(lowerCasedText) ||
                $0.symbol.lowercased().contains(lowerCasedText) ||
                $0.id.lowercased().contains(lowerCasedText)
            }
        
    }

}

