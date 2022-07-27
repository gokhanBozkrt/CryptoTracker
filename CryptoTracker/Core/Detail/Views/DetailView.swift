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
    @State private var showDescription = false
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
                ChartView(coin: vm.coin)
                    .padding(.vertical)
             
                VStack(spacing: 20) {
                    OverviewTitle
                    Divider()
                descriptionSection
                    overViewGrid
                   additionalTitle
                    Divider()
                 additionalViewGrid
               coinWebLinks
                }.padding()
            }
        }
        .background(
            Color.theme.background
                .ignoresSafeArea()
        )
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
            navBarTrailingItems
            }
        }
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
    private var navBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryTextColor)
                    Button {
                        withAnimation(.easeInOut) {
                            showDescription.toggle()
                        }
                    } label: {
                        Text(!showDescription ? "Read More..." : "Less")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical,4)
                        }
                    .tint(.blue)
                    .frame(maxWidth: .infinity,alignment: .leading)

                }
            }
        }
    }
    private var coinWebLinks: some View {
        VStack(alignment: .leading,spacing:20) {
            if let websiteString = vm.websiteUrl,
                   let url = URL(string: websiteString) {
                    Link("Website", destination: url)
                }
                if let redditUrl = vm.redditUrl,
                   let url = URL(string: redditUrl) {
                    Link("Reddit", destination: url)
                }
            
        }
        .tint(.blue)
        .frame(maxWidth: .infinity,alignment: .leading)
        .font(.headline)
    }
}
