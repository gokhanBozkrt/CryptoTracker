//
//  MarketData.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 12.07.2022.
//

import Foundation

// JSON DATA
/*
 URL: https://api.coingecko.com/api/v3/global

 Json Response:
 {
   "data": {
     "active_cryptocurrencies": 13421,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 525,
     "total_market_cap": {
       "btc": 46451864.19850712,
       "eth": 853547132.6710476,
       "ltc": 18960091952.75482,
       "bch": 9218989801.41366,
       "bnb": 4062657475.998102,
       "eos": 975872358187.866,
       "xrp": 2942157781539.429,
       "xlm": 9008811320382.12,
       "link": 149704660055.34445,
       "dot": 141652514678.01642,
       "yfi": 161352674.45923677,
       "usd": 926358523745.5209,
       "aed": 3402561175643.487,
       "ars": 118189762582177.9,
       "aud": 1368116671115.19,
       "bdt": 86515508139395.64,
       "bhd": 349207519979.30164,
       "bmd": 926358523745.5209,
       "brl": 5017065128753.385,
       "cad": 1204155844204.8506,
       "chf": 909138445147.615,
       "clp": 937280290740479.4,
       "cny": 6229575800483.873,
       "czk": 22483647729827.57,
       "dkk": 6849087326823.934,
       "eur": 920595647369.3019,
       "gbp": 777838240708.975,
       "hkd": 7271891252439.246,
       "huf": 373645242274495.7,
       "idr": 13869427429325404,
       "ils": 3217294102687.0005,
       "inr": 73595447781296.75,
       "jpy": 126610514412180.97,
       "krw": 1209813692830724.2,
       "kwd": 285323057106.2392,
       "lkr": 333286295152049.5,
       "mmk": 1714105241589121.8,
       "mxn": 19229947737157.34,
       "myr": 4110252769858.8774,
       "ngn": 384735222081990,
       "nok": 9463167328679.148,
       "nzd": 1508887965100.6064,
       "php": 52176678817987.64,
       "pkr": 192033051101992.9,
       "pln": 4436850657349.122,
       "rub": 54122499528907.48,
       "sar": 3476801400453.5024,
       "sek": 9777737377097.062,
       "sgd": 1302633313430.1448,
       "thb": 33494950055182.83,
       "try": 16037489306491.959,
       "twd": 27662455056826.887,
       "uah": 27350428788915.18,
       "vef": 92756278982.63911,
       "vnd": 21671231304502736,
       "zar": 15708741340868.12,
       "xdr": 683928645364.2728,
       "xag": 48627866011.332344,
       "xau": 535463017.4806246,
       "bits": 46451864198507.125,
       "sats": 4645186419850712
     },
     "total_volume": {
       "btc": 3799730.1719694487,
       "eth": 69819561.58634472,
       "ltc": 1550922330.0130327,
       "bch": 754106951.5275968,
       "bnb": 332322554.89163667,
       "eos": 79825679924.30713,
       "xrp": 240666459486.66476,
       "xlm": 736914498013.5369,
       "link": 12245737033.628098,
       "dot": 11587077144.14403,
       "yfi": 13198536.507614048,
       "usd": 75775482716.79602,
       "aed": 278327136792.92773,
       "ars": 9667840347209.145,
       "aud": 111910991812.85085,
       "bdt": 7076908371550.242,
       "bhd": 28564932168.785175,
       "bmd": 75775482716.79602,
       "brl": 410392436845.8971,
       "cad": 98499110249.39146,
       "chf": 74366892268.57347,
       "clp": 76668875658026.95,
       "cny": 509574966173.9094,
       "czk": 1839146741019.359,
       "dkk": 560250577995.5945,
       "eur": 75304083438.815,
       "gbp": 63626626899.26046,
       "hkd": 594835644939.781,
       "huf": 30563920849679.57,
       "idr": 1134509513890340,
       "ils": 263172419126.9821,
       "inr": 6020056423552.157,
       "jpy": 10356651988059.457,
       "krw": 98961918330468.62,
       "kwd": 23339227554.186764,
       "lkr": 27262587055308.26,
       "mmk": 140212616151721.38,
       "mxn": 1572996345421.6042,
       "myr": 336215816814.4241,
       "ngn": 31471073481939.75,
       "nok": 774080503368.3297,
       "nzd": 123425985717.46057,
       "php": 4268016024731.2207,
       "pkr": 15708169970733.787,
       "pln": 362931296776.5404,
       "rub": 4427182805055.243,
       "sar": 284399935528.8174,
       "sek": 799812114462.8497,
       "sgd": 106554498715.08344,
       "thb": 2739863609981.4097,
       "try": 1311855466986.2598,
       "twd": 2262769577147.606,
       "uah": 2237246045528.6265,
       "vef": 7587399084.432796,
       "vnd": 1772691642676728,
       "zar": 1284964112128.7593,
       "xdr": 55944887338.84526,
       "xag": 3977725606.277937,
       "xau": 43800502.274789706,
       "bits": 3799730171969.4487,
       "sats": 379973017196944.9
     },
     "market_cap_percentage": {
       "btc": 41.10067772180731,
       "eth": 14.01725377328901,
       "usdt": 7.1089576708063955,
       "usdc": 5.973349740907632,
       "bnb": 4.015474356378107,
       "busd": 1.9305870958521938,
       "xrp": 1.6427516886743443,
       "ada": 1.594989241251086,
       "sol": 1.2819280537299351,
       "doge": 0.8869030306302487
     },
     "market_cap_change_percentage_24h_usd": -2.5165313236307183,
     "updated_at": 1657645068
   }
 }
 */


struct GlobalData: Codable {
    let data: MarketData?
}


struct MarketData: Codable {
    let activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int?
    let markets: Int?
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let updatedAt: Int?
    
    enum CodingKeys: String, CodingKey {
         case activeCryptocurrencies = "active_cryptocurrencies"
         case upcomingIcos = "upcoming_icos"
         case ongoingIcos = "ongoing_icos"
         case endedIcos = "ended_icos"
         case markets
         case totalMarketCap = "total_market_cap"
         case totalVolume = "total_volume"
         case marketCapPercentage = "market_cap_percentage"
         case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
         case updatedAt = "updated_at"
     }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
     
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
