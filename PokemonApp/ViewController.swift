//
//  ViewController.swift
//  PokemonApp
//
//  Created by Jhonathan Sanchez on 6/4/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var pokemonArray = [Pokemon]()
    var filteredPokemonArray = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = .Done
        parsePokemonCSV()
        //startPlayingMusic()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
            
        }else{
            inSearchMode = true
            let filterWord = searchBar.text!.lowercaseString
            filteredPokemonArray = pokemonArray.filter({$0.name.rangeOfString(filterWord) != nil})
            collectionView.reloadData()
            
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func startPlayingMusic(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        do{
           musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
       

    }
    
    @IBAction func musicBtnPressed(sender: UIButton!) {
        if musicPlayer.playing{
            musicPlayer.stop()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do{
            let csv =  try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemon = Pokemon(name: name, pokemonId: id)
                pokemonArray.append(pokemon)
            }
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredPokemonArray.count
        }else{
           return pokemonArray.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? CustomCell{
            
            let pokemon: Pokemon
            if inSearchMode{
                pokemon = filteredPokemonArray[indexPath.row]
            }else{
                pokemon = pokemonArray[indexPath.row]
            }
            cell.configureCell(pokemon)
            return cell
        }else{
            
            return UICollectionViewCell()
        }
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke: Pokemon!
        if inSearchMode{
            poke = filteredPokemonArray[indexPath.row]
        }else{
            poke = pokemonArray[indexPath.row]
        }
        
        performSegueWithIdentifier("Detail", sender: poke)
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Detail" {
            if let detailVC = segue.destinationViewController as? PokemonDetailViewController{
                if let poke = sender as? Pokemon{
                    detailVC.pokemon = poke
                }
            }
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }


}

