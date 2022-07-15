//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 29.06.2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false // animate right
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolioView = false // new sheet
    var body: some View {
        ZStack {
            // MARK: Background Layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }

            
            // MARK: Content Layer
            VStack {
             homeHeader
                HomeStatView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
              columnTitles
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .padding(.horizontal)
                
                Spacer(minLength: 0)
                if !showPortfolio {
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
               Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ?  "plus" : "info")
                .animation(.none, value: showPortfolio)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                       showPortfolio.toggle()
                      
                    }
                }
        } .padding(.horizontal)
    }
    
    private var allCoinList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    private var portfolioCoinList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {  Text("Holdings") }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0),anchor: .center)

        }
    }
}
