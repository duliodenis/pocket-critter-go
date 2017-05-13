//
//  CoreDataManager.swift
//  Pokecrit Go
//
//  Created by Dulio Denis on 5/13/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import UIKit
import CoreData

func createPokecrits() {
    makePokecrit(name: "Tim", with: "death")
    makePokecrit(name: "Drake", with: "dracula")
    makePokecrit(name: "Franky", with: "frankenstein")
    makePokecrit(name: "Casper", with: "ghost")
    makePokecrit(name: "Griffin", with: "invisible-man")
    makePokecrit(name: "Gilman", with: "swampy")
    makePokecrit(name: "Mambo", with: "voodoo-doll")
    makePokecrit(name: "Talbot", with: "werewolf")
    makePokecrit(name: "Elphaba", with: "witch")
    makePokecrit(name: "Brian", with: "zombie")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}


func makePokecrit(name: String, with imageName: String) {
    let context = AppDelegate.viewContext
    
    let pokecrit = Pokecrit(context: context)
    pokecrit.name = name
    pokecrit.imageURL = imageName
}


func getAllPokecrits() -> [Pokecrit] {
    let context = AppDelegate.viewContext
    
    do {
        let pokecrits = try context.fetch(Pokecrit.fetchRequest()) as! [Pokecrit]
        if pokecrits.count == 0 {
            createPokecrits()
            return getAllPokecrits()
        }
        return pokecrits
    } catch {
        print("Error obtaining Pokecrits from Core Data.")
    }
    
    return []
}
