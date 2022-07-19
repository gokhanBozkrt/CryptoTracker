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
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    @StateObject private var vm: DetailViewModel
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("initializing detail view for: \(coin.name)")
    }
    var body: some View {
        ScrollView {
            VStack {
                Text("fff")
                    .frame(height: 150)
                OverviewTitle
                Divider()
                overViewGrid
               additionalTitle
                Divider()
             additionalViewGrid
            }.padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}




extension DetailView {
    private var OverviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    private var additionalTitle: some View {
        Text("Additional Details")
        .font(.title)
        .bold()
        .foregroundColor(Color.theme.accent)
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    private var overViewGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: spacing, pinnedViews: []) {
            ForEach(vm.overviewStatistics) { overview in
               StatisticView(stat: overview)
            }
        }
    }
    private var additionalViewGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: spacing, pinnedViews: []) {
            ForEach(vm.additionalStatistics) { additional in
               StatisticView(stat: additional)
            }
        }
    }
    
}
