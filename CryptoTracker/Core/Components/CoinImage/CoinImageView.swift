//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 9.07.2022.
//

import SwiftUI



struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryTextColor)
            }
        }
    }
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
