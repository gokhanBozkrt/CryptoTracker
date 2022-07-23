//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 19.07.2022.
//

import Combine
import Foundation

class DetailViewModel: ObservableObject {
    @Published var overviewStatistics = [Statistic]()
    @Published var additionalStatistics = [Statistic]()
    @Published var coin: Coin
    @Published var coinDescription: String? = nil
    @Published var websiteUrl: String? = nil
    @Published var redditUrl: String? = nil
    
    private let coinDetailService: CoinDetailDataService
    private var cancallables = Set<AnyCancellable>()
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mappedDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                guard let self = self else { return }
                self.overviewStatistics = returnedArrays.overview
                self.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancallables)
        coinDetailService.$coinDetails
            .sink { [weak self] (receivedDetails) in
                guard let self = self else { return }
                self.coinDescription = receivedDetails?.readableDescription
                self.websiteUrl = receivedDetails?.links?.homepage?.first
                self.redditUrl = receivedDetails?.links?.subredditURL
            }
            .store(in: &cancallables)
    }
    
    private func mappedDataToStatistics(coinDetails: CoinDetail?,coin: Coin) -> (overview: [Statistic],additional: [Statistic])  {
       return ( createOverviewArray(coin: coin),createAdditionalArray(coinDetails: coinDetails, coin: coin))
        
    }
    
    private func createOverviewArray(coin: Coin) -> [Statistic] {
        // Overview
          let price = coin.currentPrice.asCurrencyWith6Decimals()
          let pricePercentChange = coin.priceChangePercentage24H
          let priceStat = Statistic(title: "Current Price", value: price, percentageChange: pricePercentChange)
          
          let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
          let marketCapPercentChange = coin.marketCapChangePercentage24H
          let marketCapStat = Statistic(title: "Market Capitilization", value: marketCap, percentageChange: marketCapPercentChange)
          
          let rank = String(coin.rank)
          let rankStat = Statistic(title: "Rank", value: rank)
          
          let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
          let volumeStat = Statistic(title: "Volume", value: volume)
          
          let overviewArray: [Statistic] = [
          priceStat,marketCapStat,rankStat,volumeStat
          ]
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetails: CoinDetail?,coin: Coin) -> [Statistic] {
        // Additional
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let hightStat = Statistic(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? ""
        let lowStat = Statistic(title: "24h Low ", value: low)
        
        let priceChange = coin.priceChangePercentage24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange2 = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Chane", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange =  "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetails?.blockTimeInMinutes ?? 0
        let blokTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blokTimeString)
        
        let hashing = coinDetails?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)
        let additionalArray: [Statistic] = [
        hightStat,lowStat,priceChangeStat,marketCapChangeStat,blockStat,hashingStat
        ]
        return additionalArray
    }
}
