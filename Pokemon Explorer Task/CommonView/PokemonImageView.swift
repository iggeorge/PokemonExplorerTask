//
//  PokemonImageView.swift
//  Pokemon Explorer Task
//
//  Created by George on 23/09/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonImageView: View {
    let urlString: String

    @State private var isLoaded = false

    var body: some View {
        ZStack {
            if !isLoaded {
                ProgressView()
            }

            if let url = URL(string: urlString) {
                WebImage(url: url)
                    .onSuccess { _, _, _ in
                        withAnimation(.easeIn(duration: 0.5)) {
                            isLoaded = true
                        }
                    }
                    .resizable()
                    .scaledToFit()
                    .opacity(isLoaded ? 1 : 0) // Fade in manually
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
            }
        }
    }
}

