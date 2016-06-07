//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by Jhonathan Sanchez on 6/5/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var CurrentimageView: UIImageView!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokeIdLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var tyoeLbl: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    @IBOutlet weak var pokeImgView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalizedString
        pokeImgView.image = UIImage(named: "\(pokemon.pokemonID)")
        pokeIdLbl.text = "\(pokemon.pokemonID)"
        
        pokemon.downloadDataForPokemon()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setPokemonInfo), name: "downloadComplete", object: nil)


        // Do any additional setup after loading the view.
    }
    
    func setPokemonInfo(){
        performSelectorOnMainThread(#selector(setPokemonInfoONMainThread), withObject: nil, waitUntilDone: true)
        
    }
    
    
    func setPokemonInfoONMainThread(){
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        bioLbl.text = pokemon.description
        tyoeLbl.text = pokemon.type
        nextImageView.image = UIImage(named: "\(pokemon.nextEvoId)")
        CurrentimageView.image = UIImage(named: "\(pokemon.pokemonID)")
        
        if pokemon.nextEvoId == "" {
           evolutionLbl.text = "No Evolution"
            nextImageView.hidden = true
        }else{
           evolutionLbl.text = "Next Evolution: \(pokemon.nextEvoTxt) - Lvl: \(pokemon.nextEvoLvl)"
        }
            
        
    }
    
    

    @IBAction func backButtonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
