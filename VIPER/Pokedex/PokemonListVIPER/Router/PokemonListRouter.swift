//
//  PokemonRouter.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation

protocol PokemonListProtocolRouter: AnyRouter {
    func startPokemonData()
}

class PokemonListRouter: PokemonListProtocolRouter {
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        //init router
        let router = PokemonListRouter()
        
        //init VIP
        var view: AnyView = PokemonListView()
        var interactor: AnyInteractor = PokemonListInteractor()
        var presenter: AnyPresenter = PokemonListPresenter()
        
        //atribuição
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        router.entry = view as? EntryPoint
        
        return router
    }
    
    static func back() {}
    
    public func startPokemonData() {
        let pokemonDataRouter = PokemonDataRouter.start()
        let currentEntryPoint = self.entry as? PokemonListView
        let currentPresenter = currentEntryPoint?.presenter as? PokemonListPresenter
        
        guard let pkmDataEntry = pokemonDataRouter.entry else { return }
        currentPresenter?.delegate = pkmDataEntry.presenter as? PokemonDataPresenter
        
        self.entry?.navigationController?.pushViewController(pkmDataEntry, animated: true)
    }
}
