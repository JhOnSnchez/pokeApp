//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Jhonathan Sanchez on 6/4/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokemonID: Int!
    
    var name: String{
        return _name
    }
    
    var pokemonID: Int{
        return _pokemonID
    }
    
    init(name: String, pokemonId: Int){
        self._name = name
        self._pokemonID = pokemonId
    }
    
    
}