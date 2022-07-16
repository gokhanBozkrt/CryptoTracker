//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 12.07.2022.
//

import SwiftUI

struct StatisticView: View {
    let stat: Statistic
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >=  0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentString()  ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red )
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.stat)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
            StatisticView(stat: dev.stat3)
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
                .padding()
                
        }
    }
}
