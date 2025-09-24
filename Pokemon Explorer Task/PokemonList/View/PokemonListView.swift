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
        
        //        VStack {
        ////            Image(systemName: "globe")
        ////                .imageScale(.large)
        ////                .foregroundColor(.blue) // ✅ works on iOS 14
        ////            Text("Hello, world!")
        //        }
        ////        .padding()
        ///
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if viewModel.pokemonList.isEmpty{
                ProgressView("Loading Pokemon")
            } else {
                List(viewModel.pokemonList) { pokemon in
                    Text(pokemon.name.capitalized)
                }
            }
        }
        
        .onAppear {
            Task{
                await viewModel.fetchPokemon()
                
            }
        }
    }
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
