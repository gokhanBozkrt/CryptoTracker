//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 27.06.2022.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
           // ContentView()
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
