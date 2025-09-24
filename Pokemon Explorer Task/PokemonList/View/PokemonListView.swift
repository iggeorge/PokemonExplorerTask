//
//  PokemonListView.swift
//  Pokemon Explorer Task
//
//  Created by George on 23/09/25.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    @State var isRefreshing: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .padding()
                    Button("Retry") {
                        getPokemonList()
                    }
                } else if viewModel.pokemonList.isEmpty {
                    ProgressView("Loading Pokemon")
                } else {
                    List(viewModel.pokemonList, selection: $viewModel.selectedPokemon) { pokemon in
                        NavigationLink(pokemon.name) {
                            PokemonDetailView(info: pokemon)
                        }
                    }
                    .refreshableCompat(isRefreshing: $isRefreshing) {
                        isRefreshing = true
                        getPokemonList()
                    }
                }
            }
            .onAppear {
                getPokemonList()
            }
            .navigationTitle("Pokemon List")
        }
    }
    
    private func getPokemonList() {
        Task{
            await viewModel.fetchPokemon()
            isRefreshing = false
        }
    }
}
