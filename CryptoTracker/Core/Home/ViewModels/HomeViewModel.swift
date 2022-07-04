//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 4.07.2022.
//

import Foundation


class HomeViewModel: ObservableObject {
    @Published var allCoins = [Coin]()
    @Published var portfolioCoins = [Coin]()
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)

        }
    }
}
