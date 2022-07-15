//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 4.07.2022.
//

import Combine
import Foundation


class HomeViewModel: ObservableObject {
  
    @Published var statistics = [Statistic]()
        
    @Published var allCoins : [Coin] = []
    @Published var portfolioCoins = [Coin]()
    @Published var searchText = ""
  
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfoloioDataService = PortfolioDataService()
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
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filteredCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
        // MARK: Updates market data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                guard let self = self else { return }
                self.statistics = returnedStats
            }
            .store(in: &cancelables)
        //MARK: UPDATE PORTFOLIO
        $allCoins
            .combineLatest(portfoloioDataService.$savedEntities)
            .map { (coinModels,portfolioEntities) -> [Coin] in
                coinModels
                    .compactMap { coin -> Coin? in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = returnedCoins
            }
            .store(in: &cancelables)
        
    }
    
    func updatePorfolio(coin: Coin,amount: Double) {
        portfoloioDataService.updatePortfolio(coin: coin, amount: amount)
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
    
    private func mapGlobalMarketData(marketData: MarketData?) -> [Statistic] {
            var stats: [Statistic] = []
        guard let data = marketData else {
            return stats
        }
            let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            let volume = Statistic(title: "24h Volume", value: data.volume)
            let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
            let portfolio = Statistic(title: "Portfolio Value", value: "$0.000", percentageChange: 0)
            stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
            ])
            return stats
    }

}

