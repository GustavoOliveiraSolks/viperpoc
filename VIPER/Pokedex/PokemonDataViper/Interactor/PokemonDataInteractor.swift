//
//  PokemonDataInteractor.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation

protocol PokemonDataProtocolInteractor: AnyInteractor {
    func getPokemonData(url: String)
}

class PokemonDataInteractor: PokemonDataProtocolInteractor {
    var presenter: AnyPresenter?
    
    func getPokemonData(url: String) {
        guard let url = URL(string: url) else { return }
        let pkmPresenter = self.presenter as? PokemonDataPresenter
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                pkmPresenter?.interactorDidFetchPokemon(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                pkmPresenter?.interactorDidFetchPokemon(with: .success(pokemon))
            } catch {
                pkmPresenter?.interactorDidFetchPokemon(with: .failure(error))
            }
        }
        task.resume()
    }
 
}
