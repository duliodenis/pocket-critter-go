//
//  BackpackViewController.swift
//  Pokecrit Go
//
//  Created by Dulio Denis on 5/13/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import UIKit

class BackpackViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var capturedPokecrits: [Pokecrit] = []
    var nonCapturedPokecrits: [Pokecrit] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        capturedPokecrits = getCapturedPokecrits(captured: true)
        nonCapturedPokecrits = getCapturedPokecrits(captured: false)
        
        print("Captured Pokecrits: \(capturedPokecrits.count)")
        print("Non captured Pokecrits: \(nonCapturedPokecrits.count)")
        
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
}


extension BackpackViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if its the first section return Captured Pokecrits
        if section == 0 {
            return capturedPokecrits.count
        }
        
        return nonCapturedPokecrits.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // captured (0) and noncaptured (1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokecritCell", for: indexPath)
        
        var pokecrit: Pokecrit
        if indexPath.section == 0 {
            pokecrit = capturedPokecrits[indexPath.row]
        } else {
            pokecrit = nonCapturedPokecrits[indexPath.row]
        }
        
        cell.textLabel?.text = pokecrit.name
        cell.imageView?.image = UIImage(named: pokecrit.imageURL!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // if its the first section return Captured Pokecrits
        if section == 0 {
            return "Captured Pokecrits"
        }
        
        return "Noncaptured Pokecrits"
    }
    
}
