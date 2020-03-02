//
//  ViewController.swift
//  NASA-Meteors
//
//  Created by Daniel Farrell on 02/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var discoverMeteorsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discoverMeteorsButton.layer.cornerRadius = 25
    }

    @IBAction func discoverMeteorsPressed(_ sender: Any) {
        performSegue(withIdentifier: "discoverMeteorsSegue", sender: self)
    }

}

