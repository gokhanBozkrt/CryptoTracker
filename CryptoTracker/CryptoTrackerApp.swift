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
    @State private var showLaunchView = true
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [ .foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [ .foregroundColor : UIColor(Color.theme.accent)]

    }
    var body: some Scene {
        WindowGroup {
           // ContentView()
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
            }
        }
    }
}
