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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Pokemon Name: \(pokemon.name)")
        

        // Do any additional setup after loading the view.
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
