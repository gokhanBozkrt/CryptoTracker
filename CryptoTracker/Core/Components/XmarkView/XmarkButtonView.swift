//
//  XmarkButtonView.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 13.07.2022.
//

import SwiftUI

struct XmarkButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
         dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

struct XmarkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButtonView()
    }
}
