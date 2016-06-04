//
//  CustomCell.swift
//  PokemonApp
//
//  Created by Jhonathan Sanchez on 6/4/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokemonID)")
        
    }
    
}
