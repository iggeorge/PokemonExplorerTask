//
//  PokemonDetailModel.swift
//  Pokemon Explorer Task
//
//  Created by George on 24/09/25.
//

import Foundation

struct PokemonDataModel: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [TypeEntry]

    struct Sprites: Decodable {
        let front_default: String?
        let other: OtherSprites?
        
        struct OtherSprites: Decodable {
            let officialArtwork: OfficialArtwork?

            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
        
            struct OfficialArtwork: Decodable{
                let front_default: String?
                
            }
        }
    }

    struct TypeEntry: Decodable {
        let type: TypeName
        struct TypeName: Decodable {
            let name: String
        }
    }

    var imageURLString: String? {
        sprites.other?.officialArtwork?.front_default ?? sprites.front_default
    }
}
