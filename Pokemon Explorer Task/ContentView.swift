//
//  ContentView.swift
//  Pokemon Explorer Task
//
//  Created by George on 23/09/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var pokemonList: [PokemonModel] = []
    @State private var errorMessage: String?
    
    var body: some View {
        
        //        VStack {
        ////            Image(systemName: "globe")
        ////                .imageScale(.large)
        ////                .foregroundColor(.blue) // ✅ works on iOS 14
        ////            Text("Hello, world!")
        //        }
        ////        .padding()
        ///
        VStack {
            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if pokemonList.isEmpty{
                ProgressView("Loading Pokemon")
            } else {
                List(pokemonList) { pokemon in
                    Text(pokemon.name.capitalized)
                }
            }
        }
        
        .task {
            await fetchPokemon()
            
        }
    }
    
    func fetchPokemon() async {
            do {
                let response = try await NetworkManager.shared.fetchPokemonList(limit: 20)
                // Check what is returned in console
                print("Response from server: \(response)")
                DispatchQueue.main.async {
                    self.pokemonList = response.result
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                print("Error fetching Pokémon: \(error)")
            }
        }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
