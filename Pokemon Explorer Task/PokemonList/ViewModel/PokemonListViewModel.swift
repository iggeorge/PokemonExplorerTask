//
//  PokemonListViewModel.swift
//  Pokemon Explorer Task
//
//  Created by George on 24/09/25.
//
import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonModel] = []
    @Published var errorMessage: String?
    @Published var selectedPokemon: PokemonModel?

    func fetchPokemon() async {
        do {
            let response = try await NetworkManager.shared.fetchPokemonList()
            // print("Response from server: \(response)")
            print("list success")
            await MainActor.run { [weak self] in
                self?.errorMessage = nil
                self?.pokemonList = response.results
            }
        } catch {
            print("Error fetching Pokémon: \(error)")
            await MainActor.run { [weak self] in
                self?.errorMessage = "Oops! Something went wrong"
            }
        }
    }
}
