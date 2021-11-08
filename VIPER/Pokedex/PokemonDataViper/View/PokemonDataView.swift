//
//  PokemonDataView.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation
import UIKit

protocol PokemonDataProtocolView: AnyView {
    func fillPokemonData(with pokemon: Pokemon)
    func fillPokemonData(with error: String)
}


class PokemonDataView: UIViewController, PokemonDataProtocolView {
    var presenter: AnyPresenter?
    
    var nameLabel: UILabel!
    var abilityLabel: UILabel!
    var weightLabel: UILabel!
    
    func fillPokemonData(with pokemon: Pokemon) {
        DispatchQueue.main.async {
            self.nameLabel.text = pokemon.name
            self.abilityLabel.text = pokemon.abilities.first?.ability.name
            self.weightLabel.text = pokemon.weight.description
        }
    }
    
    func fillPokemonData(with error: String) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .right
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20.0),
            nameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10.0)
        ])
        
        abilityLabel = UILabel()
        abilityLabel.translatesAutoresizingMaskIntoConstraints = false
        abilityLabel.textAlignment = .right
        view.addSubview(abilityLabel)
        NSLayoutConstraint.activate([
            abilityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
            abilityLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
        
        weightLabel = UILabel()
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.textAlignment = .right
        view.addSubview(weightLabel)
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: abilityLabel.bottomAnchor, constant: 10.0),
            weightLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
}
