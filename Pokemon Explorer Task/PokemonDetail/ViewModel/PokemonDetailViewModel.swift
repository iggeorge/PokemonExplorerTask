//
//  PokemonDetailViewModel.swift
//  Pokemon Explorer Task
//
//  Created by George on 24/09/25.
//

import SwiftUI

class PokemonDetailViewModel: ObservableObject {
    var pokemonInfo: PokemonModel
    @Published var DisplayModel: PokemonDataModel?
    @Published var errorMessage: String?

    init(info: PokemonModel) {
        pokemonInfo = info
    }
    
    func getPokemonDetails() async {
        do {
            let response = try await NetworkManager.shared.fetchPokemonDetails(name: pokemonInfo.name)
            print("details success")
            await MainActor.run { [weak self] in
                self?.errorMessage = nil
                self?.DisplayModel = response
            }
        } catch {
            print("Error fetching Pokémon details: \(error)")
            await MainActor.run { [weak self] in
                self?.errorMessage = "Oops! Something went wrong"
            }
        }
    }
}
