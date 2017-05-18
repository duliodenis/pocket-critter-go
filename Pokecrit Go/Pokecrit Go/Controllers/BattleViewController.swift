//
//  BattleViewController.swift
//  Pokecrit Go
//
//  Created by Dulio Denis on 5/18/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import UIKit
import SpriteKit


class BattleViewController: UIViewController {
    
    var pokecrit: Pokecrit!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = BattleScene(size: CGSize(width: view.frame.size.width, height: view.frame.size.height))
        scene.scaleMode = .aspectFill
        scene.pokecrit = pokecrit
        
        self.view = SKView()
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        
        skView.presentScene(scene)
    }

}
