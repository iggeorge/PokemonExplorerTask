//
//  PokemonDetailView.swift
//  Pokemon Explorer Task
//
//  Created by George on 24/09/25.
//

import SwiftUI


struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel

    init(info: PokemonModel) {
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(info: info))
    }
    var body: some View {
        VStack(spacing: 10) {
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .padding()
                Button("Retry") {
                    getDetails()
                }
            } else if let displayModel = viewModel.DisplayModel {
                PokemonImageView(urlString: displayModel.imageURLString ?? "")
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 5))
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                Text(displayModel.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.orange)
                HStack{
                    Text("Height: \(displayModel.height)")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.red)
                    Text("Weight: \(displayModel.weight)")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.red)
                }
                HStack {
                    ForEach(Array(displayModel.types.enumerated()), id: \.offset) { index, type in
                        Text(type.type.name)
                            .bold()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(16)
                            .frame(alignment: .center)
                    }
                }
                .padding(.horizontal, 50)
            } else {
                ProgressView("Loading Pokemon Details")
            }
        }
        .onAppear {
            getDetails()
        }
    }

    private func getDetails() {
        Task {
            await viewModel.getPokemonDetails()
        }
    }
}

