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
    @Published var isLoading = false
    @Published var sortOption: SortOption = .holdings
  
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfoloioDataService = PortfolioDataService()
    private var cancelables = Set<AnyCancellable>()
   
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed,price,priceReversed
    }
    
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
            .combineLatest(coinDataService.$allCoins,$sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filteredAndSortedCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
        //MARK: UPDATE PORTFOLIO
        $allCoins
            .combineLatest(portfoloioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancelables)
            
        
        // MARK: Updates market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                guard let self = self else { return }
                self.statistics = returnedStats
                self.isLoading = false
            }
            .store(in: &cancelables)

    }
    
    func updatePorfolio(coin: Coin,amount: Double) {
        portfoloioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func filteredAndSortedCoins(text:String,startingCoins: [Coin],sort: SortOption) -> [Coin] {
        var updatedCoins = filteredCoins(text: text, startingCoins: startingCoins)
       // sort
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    private func sortCoins(sort: SortOption, coins: inout [Coin]) {
        switch sortOption {
        case .rank, .holdings:
             coins.sort { $0.rank < $1.rank }
        case .rankReversed, .holdingsReversed:
             coins.sort { $0.rank > $1.rank }
        case .price:
             coins.sort { $0.currentPrice < $1.currentPrice }
        case .priceReversed:
             coins.sort { $0.currentPrice > $1.currentPrice }
        }
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
    
    private func mapAllCoinsToPortfolioCoins(coinModels: [Coin],portfolioEntities: [PortfolioEntity]) -> [Coin] {
        coinModels.compactMap { coin -> Coin? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapGlobalMarketData(marketData: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
            var stats: [Statistic] = []
        guard let data = marketData else {
            return stats
        }
            let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            let volume = Statistic(title: "24h Volume", value: data.volume)
            let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
//        let portfolioValue = portfolioCoins.map { (coin) -> Double in
//            return coin.currentHoldingsValue
//        }
        let portfolioValue = portfolioCoins.map( { $0.currentHoldingsValue }).reduce(0, +)
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
        .reduce(0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
    
        
        let portfolio = Statistic(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
            stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
            ])
            return stats
    }

}

