//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 25.07.2022.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "Portfolyon Yükleniyor...".map { String($0)}
    @State private var showLoading = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    @State private var loops = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack {
                if showLoading {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) {  index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launch.accent)
                                .offset(y: counter == index ? -10 : 0)
                        }
                    }.transition(AnyTransition.scale.animation(.easeIn))
                       
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoading.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
