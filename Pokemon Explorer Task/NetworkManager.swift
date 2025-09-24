//
//  NetworkManager.swift
//  Pokemon Explorer Task
//
//  Created by George on 23/09/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    private let baseURL = "https://pokeapi.co/api/v2/"
    
    func fetchPokemonList(limit: Int = 20)async throws -> PokemonListResponse {
        let urlString = "\(baseURL)pokemon?limit=\(limit)"
        guard let url = URL(string: urlString) else{
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return decoded
    }
    
    func fetchPokemonDetails(url:String)async throws -> PokemonModel {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PokemonModel.self, from: data)
        return decoded
    }
}
