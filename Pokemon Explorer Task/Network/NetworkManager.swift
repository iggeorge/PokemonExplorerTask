//
//  NetworkManager.swift
//  Pokemon Explorer Task
//
//  Created by George on 23/09/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    private let baseURL = "https://pokeapi.co/api/v2/pokemon"

    func fetchPokemonList(limit: Int = 20) async throws -> PokemonListResponse {
        let urlString = "\(baseURL)?limit=\(limit)"
        guard let url = URL(string: urlString) else{
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return decoded
    }

    func fetchPokemonDetails(name: String) async throws -> PokemonDataModel {
        let urlString = baseURL + "/" + name
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PokemonDataModel.self, from: data)
        return decoded
    }
}
