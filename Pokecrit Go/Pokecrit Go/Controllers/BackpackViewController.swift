//
//  BackpackViewController.swift
//  Pokecrit Go
//
//  Created by Dulio Denis on 5/13/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import UIKit

class BackpackViewController: UIViewController {
    
    var capturedPokecrits: [Pokecrit] = []
    var nonCapturedPokecrits: [Pokecrit] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capturedPokecrits = getCapturedPokecrits(captured: true)
        nonCapturedPokecrits = getCapturedPokecrits(captured: false)
        
        print("Captured Pokecrits: \(capturedPokecrits.count)")
        print("Non captured Pokecrits: \(nonCapturedPokecrits.count)")
        
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
}
