//
//  ViewController.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/22/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import UIKit

var username: String = "Name"

class StartScreenViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextBox: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Space Trader Background")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func continueGamePressed(_ sender: Any) {
        let input = usernameTextBox.text
        if input != "" {
            username = input!
            print(username)
            database.loadGame()
        }
    }
    
    @IBAction func newGamePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "touserconfig", sender: nil)
    }

}

