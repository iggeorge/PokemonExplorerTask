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
    init(info: PokemonModel) {
        pokemonInfo = info
    }
    
    func getPokemonDetails() async {
        do {
            let response = try await NetworkManager.shared.fetchPokemonDetails(name: pokemonInfo.name)
            DispatchQueue.main.async { [weak self] in
                self?.DisplayModel = response
            }
        } catch {
            print("detais error:", error)
        }
    }
}
