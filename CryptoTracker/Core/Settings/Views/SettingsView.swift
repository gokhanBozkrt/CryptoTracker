//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 24.07.2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    let defaultUrl = URL(string: "https://www.google.com")!
    let youtubeURl = URL(string: "https://www.youtube.com")!
    let coffeeURl = URL(string: "https://www.instagram.com")!
    let coinURl = URL(string: "https://www.coingecko.com")!
    let personelURl = URL(string: "https://github.com/gokhanBozkrt")!
    var body: some View {
        NavigationView {
            List {
               swiftGuySection
                coinGeckoSection
                developerSection
                applicationSection
            }.font(.headline)
            .listStyle(.grouped)
                .tint(.blue)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButtonView(dismiss: _dismiss)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var swiftGuySection: some View {
        Section {
            VStack(alignment: .leading) {
               Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Bu uygulama ***** tarafından swift ile yapılmıştır. MVVM Architecture, Combine ve Core Data teknolojileri kullanılmıştır.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }.padding(.vertical)
            Link("Youtube Abone ol 🥳", destination: youtubeURl)
            Link("Destek 💰💲💳🤑🪙", destination: coffeeURl)
        } header: {
            Text("Swift Guys")
        }

    }
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
               Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Uygulamada olan coin verileri ücretsiz sağlanan coingecko sitesinden alınmıştır.Verilerin güncellenmesinde gecikme olabilir.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }.padding(.vertical)
            Link("CoinGecko ziyaret et 🥳", destination: coinURl)
        } header: {
            Text("CoinGecko")
        }

    }
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
               Image("logo")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Bu uygulama eğitim amaçlı olarak GB tarafından geliştirilmiştir.Proje tamamen swift ile yazılmıştır.Multi thread yapısı publishers/subscribers ve data persistance den yararlanmaktadır.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }.padding(.vertical)
            Link("Gelitirici GitHub 🥳", destination: personelURl)
        } header: {
            Text("Geliştirici")
        }

    }
    private var applicationSection: some View {
        Section {
            Link("Terms of Service", destination: defaultUrl)
            Link("Privacy Policy", destination: defaultUrl)
            Link("Company  Website", destination: defaultUrl)
            Link("Learn More", destination: defaultUrl)
        } header: {
            Text("Uygulama")
        }

    }
}
