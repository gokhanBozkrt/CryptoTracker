//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 17.07.2022.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    let coin: Coin
    init(coin: Coin) {
        self.coin = coin
        print("initializing detail view for: \(coin.name)")
    }
    var body: some View {
            Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
