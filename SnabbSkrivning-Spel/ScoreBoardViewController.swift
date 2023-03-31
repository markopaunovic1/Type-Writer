//
//  ScoreBoardViewController.swift
//  SnabbSkrivning-Spel
//
//  Created by Marko Paunovic on 2023-03-21.
//

import UIKit

class ScoreBoardViewController: UIViewController {

    @IBOutlet weak var easyPointsLabel: UILabel!
    @IBOutlet weak var mediumointsLabel: UILabel!
    @IBOutlet weak var hardPointsLabel: UILabel!
    
    var easyPoints = 0
    
    // Saves the  current ALL TIME HIGHEST points
    let savedEasyPoints = UserDefaults.standard.integer(forKey: "easyPoints")
    let savedMediumPoints = UserDefaults.standard.integer(forKey: "mediumPoints")
    let savedHardPoints = UserDefaults.standard.integer(forKey: "hardPoints")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        easyPointsLabel.text = "\(savedEasyPoints)"
        mediumointsLabel.text = "\(savedMediumPoints)"
        hardPointsLabel.text = "\(savedHardPoints)"
    }
}
