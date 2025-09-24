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
            let response = try await NetworkManager.shared.fetchPokemonList(limit: 20)
            print("Response from server: \(response)")
            DispatchQueue.main.async { [weak self] in
                self?.pokemonList = response.results
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = error.localizedDescription
            }
            print("Error fetching Pokémon: \(error)")
        }
    }
}
