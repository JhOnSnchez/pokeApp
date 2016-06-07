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
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _attack: String!
    private var _weight: String!
    private var _defense: String!
    private var _nextEvoTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    var name: String{
        return _name
    }
    
    var pokemonID: Int{
        return _pokemonID
    }
    
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil{
            _weight = ""
        }

        return _weight
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }

        return _attack
    }
    
    var defense: String{
        if _defense == nil{
            _defense = ""
        }

        return _defense
    }
    
    var type: String{
        if _type == nil{
            _type = ""
        }

        return _type
    }
    
    var description: String{
        if _description == nil{
            _description = ""
        }

        return _description
    }
    
    var nextEvoId: String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }

        return _nextEvolutionId
    }
    
    var nextEvoLvl: String{
        if _nextEvolutionLvl == nil{
            _nextEvolutionLvl = ""
        }

        return _nextEvolutionLvl
    }
    
    var nextEvoTxt: String{
        if _nextEvoTxt == nil{
            _nextEvoTxt = ""
        }

        return _nextEvoTxt
    }
    
    init(name: String, pokemonId: Int){
        self._name = name
        self._pokemonID = pokemonId
        
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(pokemonId)/"
    }
    
    func downloadDataForPokemon(){
        let url = NSURL(string: self._pokemonUrl)!
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            if let result = data {
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(result, options: .AllowFragments)
                    if let resultDictionary = json as? Dictionary<String, AnyObject>{
//                        print(resultDictionary)
                        //get weight from json
                        if let weight = resultDictionary["weight"] as? String{
                            self._weight = weight
                        }
                        //get Heihgt from json
                        if let height = resultDictionary["height"] as? String{
                            self._height = height
                        }
                        //get attack from json
                        if let attack = resultDictionary["attack"] as? Int{
                            self._attack = "\(attack)"
                        }
                        //get defense from json
                        if let defense = resultDictionary["defense"] as? Int{
                            self._defense = "\(defense)"
                        }
                        //get type from json
                        if let types = resultDictionary["types"] as? [Dictionary<String, String>] where types.count > 0{
                            if let name = types[0]["name"]{
                                self._type = name.capitalizedString
                            }
                            
                            if types.count > 1{
                                for x in 1 ..< types.count{
                                    if let name = types[x]["name"]{
                                        self._type! += "/\(name.capitalizedString)"
                                    }
                                }
                            }
                        }else{
                            self._type = ""
                        }
                        
                        //get description from json
                        if let descriptionArray = resultDictionary["descriptions"] as? [Dictionary<String, String>] where descriptionArray.count > 0{
                            if let urlString = descriptionArray[0]["resource_uri"] {
                                let url = NSURL(string: "\(URL_BASE)\(urlString)")!
                                let session = NSURLSession.sharedSession()
                                session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                                    if let result = data{
                                        do{
                                            let json = try NSJSONSerialization.JSONObjectWithData(result, options: .AllowFragments)
                                            if let resultDictionary = json as? Dictionary<String, AnyObject>{
                                                if let desc = resultDictionary["description"] as? String{
                                                    self._description = desc
                                                }
                                            }
                                            print("Description: \(self._description)")
                                            //send notification that dowload was completed
                                            let noti = NSNotification(name: "downloadComplete", object: nil, userInfo: nil)
                                            NSNotificationCenter.defaultCenter().postNotification(noti)
                                            

                                        }catch{
                                            print("error")
                                        }
                                    }
                                    
                                }).resume()
                                
                            }
                            
                        }else{
                            self._description = ""
                        }
                        
                        //get nextEvolution info from json
                        if let evolutions = resultDictionary["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0{
                            
                            if let to = evolutions[0]["to"] as? String{
                                if to.rangeOfString("mega") == nil{
                                    if let uri = evolutions[0]["resource_uri"] as? String{
                                        let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                        let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                        
                                        self._nextEvolutionId = num
                                        self._nextEvoTxt = to
                                        
                                        if let lvl = evolutions[0]["level"] as? Int{
                                            self._nextEvolutionLvl = "\(lvl)"
                                        }
                                    }
                                }
                            }
                            
                        }else{

                        }
                        
                    }
                    
                } catch {
                    print("Error ")
                }
                
                
            }
        }.resume()
        
        
    }
    
    
}