//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 2.07.2022.
//

import Foundation
import SwiftUI

/*
 CoinGecko API
 
 URL:
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=try&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24
 
 
 {
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    "current_price": 322724,
    "market_cap": 6155691416777,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 6774022585520,
    "total_volume": 336040842692,
    "high_24h": 328500,
    "low_24h": 319205,
    "price_change_24h": -2496.6997818357195,
    "price_change_percentage_24h": -0.76769,
    "market_cap_change_24h": -89622973739.27734,
    "market_cap_change_percentage_24h": -1.43504,
    "circulating_supply": 19083125,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 850326,
    "ath_change_percentage": -62.06485,
    "ath_date": "2021-12-20T16:44:25.022Z",
    "atl": 392.91,
    "atl_change_percentage": 81998.45786,
    "atl_date": "2015-01-14T00:00:00.000Z",
    "roi": null,
    "last_updated": "2022-07-02T14:06:23.782Z",
    "sparkline_in_7d": {
      "price": [
        21364.177424515998,
   

      ]
    }
  }
 */

struct Coin: Identifiable,Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Int?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let currentHolding: Double?
    
    enum CodingKeys: String, CodingKey {
         case id, symbol, name, image
         case currentPrice = "current_price"
         case marketCap = "market_cap"
         case marketCapRank = "market_cap_rank"
         case fullyDilutedValuation = "fully_diluted_valuation"
         case totalVolume = "total_volume"
         case high24H = "high_24h"
         case low24H = "low_24h"
         case priceChange24H = "price_change_24h"
         case priceChangePercentage24H = "price_change_percentage_24h"
         case marketCapChange24H = "market_cap_change_24h"
         case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
         case circulatingSupply = "circulating_supply"
         case totalSupply = "total_supply"
         case maxSupply = "max_supply"
         case ath
         case athChangePercentage = "ath_change_percentage"
         case athDate = "ath_date"
         case atl
         case atlChangePercentage = "atl_change_percentage"
         case atlDate = "atl_date"
         case lastUpdated = "last_updated"
         case sparklineIn7D = "sparkline_in_7d"
         case currentHolding
     }
    
    func updateHoldings(amount: Double) -> Coin {
        return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, currentHolding: amount)
    }
    
    var currentHoldingValue: Double {
        return (currentHolding ?? 0) * currentPrice
    }
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}


struct SparklineIn7D: Codable {
    let price: [Double]?
}


