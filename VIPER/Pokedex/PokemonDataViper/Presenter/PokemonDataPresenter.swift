//
//  PokemonDataPresenter.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation

protocol PokemonDataDelegate {
    func onPokemonSelected(url: String)
}

protocol PokemonDataProtocolPresenter: AnyPresenter {
    func interactorDidFetchPokemon(with result: Result<Pokemon, Error>)
}

class PokemonDataPresenter: PokemonDataProtocolPresenter, PokemonDataDelegate {
    var router: AnyRouter?
    
    var interactor: AnyInteractor?
    
    var view: AnyView?
    
    func onPokemonSelected(url: String) {
        let pkmDataInteractor = interactor as? PokemonDataInteractor
        pkmDataInteractor?.getPokemonData(url: url)
    }
    
    func interactorDidFetchPokemon(with result: Result<Pokemon, Error>) {
        let pkmView = self.view as? PokemonDataView
        switch result {
        case .success(let pokemon):
            pkmView?.fillPokemonData(with: pokemon)
        case .failure:
            pkmView?.fillPokemonData(with: "Deu ruim")
        }
    }
}
