//
//  Interactor.swift
//  Pokedex
//
//  Created by Gustavo Oliveira on 23/10/21.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
}
