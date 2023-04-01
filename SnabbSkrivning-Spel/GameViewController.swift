//
//  GameViewController.swift
//  SnabbSkrivning-Spel
//
//  Created by Marko Paunovic on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var getReadyLabel: UILabel!
    @IBOutlet weak var readyCountdownLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var randomTextLabel: UILabel!
    
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var selectDifficultyBtn: UIButton!
    @IBOutlet weak var startBtn2: UIButton!
    
    var wordClass = CollectionWords<String>()
    var seugeIDgameOver = "gameOver"
    
    var difficulty = ["Easy", "Medium", "Hard"]
    
    var initialTimer = Timer()
    var initialSeconds = 3
    
    var timer = Timer()
    var countdownTimer = 20
    
    var earnedPoints = 0

    var currentWord = ""
    var currentDifficulty = ""
    
    var highScoreEasy = UserDefaults.standard.integer(forKey: "highScoreEasy")
    var highScoreMedium = UserDefaults.standard.integer(forKey: "highScoreMedium")
    var highScoreHard = UserDefaults.standard.integer(forKey: "highScoreHard")
    
    // Choose different difficulty from a pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return difficulty.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficulty[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectDifficultyBtn.setTitle(difficulty[row], for: .normal)
        pickerView.isHidden = true
        startBtn2.isHidden = false
        
        selectDifficultyBtn.isUserInteractionEnabled = false
        
        if row == 0 {
            currentDifficulty = "Easy"
            getEasyRandomWords()
        } else if row == 1 {
            currentDifficulty = "Medium"
            getMediumRandomWords()
        } else  if row == 2 {
            currentDifficulty = "Hard"
            getHardRandomWords()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pickerView.isHidden = true
        startBtn2.isHidden = true
        
        textInput.delegate = self
        
        getReadyLabel.isHidden = true
        readyCountdownLabel.isHidden = true
        timerLabel.isHidden = true
        randomTextLabel.isHidden = true
    }
    
    // Starts the round by pressing START button
    @IBAction func startBtn(_ sender: UIButton) {
        startBtn2.isHidden = true
        
        textInput.becomeFirstResponder()
        
        getReadyTimer()
        getReadyLabel.isHidden = false
        readyCountdownLabel.isHidden = false
        
    }
    @IBAction func pickerViewBtn(_ sender: UIButton) {
        
        if pickerView.isHidden {
            pickerView.isHidden = false
        }
    }
    
    //  Usen the Enter key to check if the given word is spelled correctly
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkAnswer()
        return true
    }
    
    // Get the random words from a collections of words
    func getEasyRandomWords() {
        currentWord = wordClass.easyWords.randomElement() ?? ""
        randomTextLabel.text = currentWord
    }
    
    func getMediumRandomWords() {
        currentWord = wordClass.mediumWords.randomElement() ?? ""
        randomTextLabel.text = currentWord
    }
    
    func getHardRandomWords() {
        currentWord = wordClass.hardWords.randomElement() ?? ""
        randomTextLabel.text = currentWord
    }
    
    // Countdown timer for the user updates each second
    func countdown() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(userCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func userCountdown() {
        countdownTimer -= 1
        updateTimer()
        if countdownTimer <= 3 {
            timerLabel.textColor = UIColor(red: 200, green: 0, blue: 0, alpha: 1)
        } else {
            timerLabel.textColor = UIColor.black
        }
        
        if countdownTimer == 0 {
            stopTimer()
            gameOver()
            randomTextLabel.isHidden = true
            timerLabel.isHidden = true
        }
    }
    
    // Updates the timer every second
    func updateTimer() {
        timerLabel.text = "\(countdownTimer)"
    }
    
    // Stops the timer
    func stopTimer() {
        timer.invalidate()
    }
    
    // Preperation timer
    func getReadyTimer() {
        initialTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getReadyCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func getReadyCountdown() {
        initialSeconds -= 1
        updateGetReadyTimer()
        
        if initialSeconds == 0 {
            stopGetReadyTimer()
            
            getReadyLabel.isHidden = true
            readyCountdownLabel.isHidden = true
            randomTextLabel.isHidden = false
            timerLabel.isHidden = false
            
            countdown()
        }
    }
    
    func updateGetReadyTimer() {
        readyCountdownLabel.text = "\(initialSeconds)"
    }
    
    func stopGetReadyTimer() {
        initialTimer.invalidate()
    }
    
    // Checks the answer by the given word
    func checkAnswer() {
        
        if textInput.text == randomTextLabel.text {
            earnedPoints += 1
            countdownTimer += 1
            
            pointsLabel.text = "\(earnedPoints)"
            
            // Gets the new random word from and sends the new highscore if earnedPoints > highScore
            
            if (currentDifficulty == "Easy") {
                getEasyRandomWords()
                
                 if (earnedPoints > highScoreEasy) {
                     highScoreEasy = earnedPoints
                    UserDefaults.standard.set(highScoreEasy, forKey: "highScoreEasy")
                }
                
            } else if (currentDifficulty == "Medium")  {
                getMediumRandomWords()
                
                if earnedPoints > highScoreMedium {
                    highScoreMedium = earnedPoints
                    UserDefaults.standard.set(highScoreMedium, forKey: "highScoreMedium")
                }
                
            } else if (currentDifficulty == "Hard"){
                getHardRandomWords()
                
                if earnedPoints > highScoreHard {
                    highScoreHard = earnedPoints
                    UserDefaults.standard.set(highScoreHard, forKey: "highScoreHard")
                }
            }
            textInput.text = ""
        } else {
            
            // Blinks red if the word is incorrect
            textInput.backgroundColor = .white
            
            var backGroundRed = false
            var blinkCount = 0
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {timer in backGroundRed.toggle()
                self.textInput.backgroundColor = backGroundRed ? .systemRed : .white
                blinkCount += 1
                if blinkCount >= 4 {
                    timer.invalidate()
                }
            }
        }
    }
    func gameOver() {
        performSegue(withIdentifier: seugeIDgameOver, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seugeIDgameOver {
            if let destinationVC = segue.destination as? GameOverViewController
            {
                destinationVC.getPoints = earnedPoints
            }
        }
    }
}
