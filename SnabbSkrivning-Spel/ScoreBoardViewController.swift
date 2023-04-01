//
//  ScoreBoardViewController.swift
//  SnabbSkrivning-Spel
//
//  Created by Marko Paunovic on 2023-03-21.
//

import UIKit

class ScoreBoardViewController: UIViewController {

    @IBOutlet weak var easyPointsLabel: UILabel!
    @IBOutlet weak var mediumPointsLabel: UILabel!
    @IBOutlet weak var hardPointsLabel: UILabel!
    
    // Saves the  current ALL TIME HIGHEST points
    let savedEasyPoints = UserDefaults.standard.integer(forKey: "highScoreEasy")
    let savedMediumPoints = UserDefaults.standard.integer(forKey: "highScoreMedium")
    let savedHardPoints = UserDefaults.standard.integer(forKey: "highScoreHard")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        easyPointsLabel.text = "\(savedEasyPoints)"
        mediumPointsLabel.text = "\(savedMediumPoints)"
        hardPointsLabel.text = "\(savedHardPoints)"
    }
}
