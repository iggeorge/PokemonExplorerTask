//
//  PokemonListView.swift
//  Pokemon Explorer Task
//
//  Created by George on 23/09/25.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.pokemonList.isEmpty {
                    ProgressView("Loading Pokemon")
                } else {
                    List(viewModel.pokemonList, selection: $viewModel.selectedPokemon) { pokemon in
                        NavigationLink(pokemon.name) {
                            PokemonDetailView(info: pokemon)
                        }
                    }
                }
            }
            .onAppear {
                Task{
                    await viewModel.fetchPokemon()
                }
            }
            .navigationTitle("Pokemon List")
        }
    }
}
