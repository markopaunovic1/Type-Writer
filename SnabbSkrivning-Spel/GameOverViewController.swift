//
//  GameOverViewController.swift
//  SnabbSkrivning-Spel
//
//  Created by Marko Paunovic on 2023-03-28.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var highestStreakLabel: UILabel!
    
    var getPoints = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highestStreakLabel.text = "\(getPoints)"

    }
}
    

