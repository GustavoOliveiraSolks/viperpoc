//
//  PokemonDataRouter.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation

protocol PokemonDataProtocolRouter: AnyRouter {
}

class PokemonDataRouter: PokemonDataProtocolRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let pokemonDataRouter = PokemonDataRouter()
        //init VIP
        let view = PokemonDataView()
        let interactor = PokemonDataInteractor()
        let presenter = PokemonDataPresenter()
        // atribuição
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = pokemonDataRouter
        
        pokemonDataRouter.entry = view
        return pokemonDataRouter
    }
    
    static func back() {} 
}
