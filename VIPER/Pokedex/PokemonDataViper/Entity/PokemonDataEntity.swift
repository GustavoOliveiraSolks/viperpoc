//
//  PokemonDataEntity.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation

// MARK: - Empty
struct Pokemon: AnyEntity {
    let abilities: [Ability]
    let baseExperience: Int
    let forms: [Species]
    let height: Int
    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let name: String
    let order: Int
    let species: Species
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case height
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case name, order
        case species, weight
    }
}

// MARK: - Ability
struct Ability: AnyEntity {
    let ability: Species
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species: AnyEntity {
    let name: String
    let url: String
}
