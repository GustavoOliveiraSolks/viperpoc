//
//  PokemonPresenter.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation

protocol PokemonListProtocolPresenter: AnyPresenter {
    func interactorDidFetchPokemonList(with result: Result<PokemonList, Error>)
    func showPokemonInfo(url: String)
    func callForMorePokemon(url: String)
}

class PokemonListPresenter: PokemonListProtocolPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            let pkmInteractor = interactor as? PokemonListInteractor
            pkmInteractor?.getPokemons(url: "https://pokeapi.co/api/v2/pokemon")
        }
    }
    
    var view: AnyView?
    var delegate: PokemonDataDelegate?
    
    func interactorDidFetchPokemonList(with result: Result<PokemonList, Error>) {
        let pkmView = self.view as? PokemonListView
        switch result {
        case .success(let pokemonList):
            pkmView?.update(with: pokemonList)
        case .failure:
            pkmView?.update(with: "Deu ruim")
        }
    }
    
    func showPokemonInfo(url: String) {
        let pkmRouter = self.router as? PokemonListRouter
        pkmRouter?.startPokemonData()
        delegate?.onPokemonSelected(url: url)
    }
    
    func callForMorePokemon(url: String) {
        let pkmInteractor = self.interactor as? PokemonListInteractor
        pkmInteractor?.getPokemons(url: url)
    }
}
