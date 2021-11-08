//
//  PokemonList.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation

// MARK: - Empty
struct PokemonList: AnyEntity {
    let count: Int
    let next: String
    let results: [Pokemons]
}

// MARK: - Result
struct Pokemons: AnyEntity {
    let name: String
    let url: String
}
