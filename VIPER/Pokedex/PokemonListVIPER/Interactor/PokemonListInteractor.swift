//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation

protocol PokemonListProtocolInteractor: AnyInteractor {
    func getPokemons(url: String)
}

class PokemonListInteractor: PokemonListProtocolInteractor {
    var presenter: AnyPresenter?
    
    func getPokemons(url: String) {
        guard let url = URL(string: url) else { return }
        let pkmPresenter = self.presenter as? PokemonListPresenter
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                pkmPresenter?.interactorDidFetchPokemonList(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                pkmPresenter?.interactorDidFetchPokemonList(with: .success(pokemonList))
            } catch {
                pkmPresenter?.interactorDidFetchPokemonList(with: .failure(error))
            }
        }
        task.resume()
    }
}
