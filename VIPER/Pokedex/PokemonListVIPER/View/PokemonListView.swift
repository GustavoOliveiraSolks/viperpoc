//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation
import UIKit

protocol PokemonListProtocolView: AnyView {
    func update(with pokemons: PokemonList)
    func update(with error: String)
}

class PokemonListView: UIViewController, PokemonListProtocolView {
    
    var presenter: AnyPresenter?
    var pokemons: PokemonList?
    var pokemonList: [Pokemons] = [Pokemons]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with pokemons: PokemonList) {
        DispatchQueue.main.async {
            self.pokemons = pokemons
            self.pokemonList.append(contentsOf: pokemons.results)
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        //todo error
    }
}

extension PokemonListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pkmPresenter = self.presenter as? PokemonListPresenter
        pkmPresenter?.showPokemonInfo(url: pokemonList[indexPath.row].url)
    }
}

extension PokemonListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pkmList = self.pokemons else { return UITableViewCell()}
        if indexPath.row == pokemonList.count - 1 {
            let pkmListPresenter = self.presenter as? PokemonListPresenter
            pkmListPresenter?.callForMorePokemon(url: pkmList.next)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = pokemonList[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
}
