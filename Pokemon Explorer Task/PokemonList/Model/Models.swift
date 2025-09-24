//
//  Models.swift
//  Pokemon Explorer Task
//
//  Created by George on 23/09/25.
//
import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonModel]
}

struct PokemonModel: Identifiable, Decodable, Hashable {
    let name: String
    let url: String
    
    var id: String { name }
}
