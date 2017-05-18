//
//  BattleScene.swift
//  Pokecrit Go
//
//  Created by Dulio Denis on 5/18/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import SpriteKit
import UIKit


class BattleScene: SKScene, SKPhysicsContactDelegate {
    
    var pokecrit: Pokecrit!
    
    override func didMove(to view: SKView) {
        print("Welcome to the Battle \(pokecrit.name!)")
    }
    
}
