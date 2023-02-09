//
//  ViewController.swift
//  Kenny Yakala
//
//  Created by Murat Çelik on 8.02.2023.
//

import UIKit

class ViewController: UIViewController {
   
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var jakeArray = [UIImageView] ()
    var hideTimer = Timer()
    var highScore = 0
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var HighscoreLabel: UILabel!
    @IBOutlet weak var Jake1: UIImageView!
    @IBOutlet weak var Jake2: UIImageView!
    @IBOutlet weak var Jake3: UIImageView!
    @IBOutlet weak var Jake4: UIImageView!
    @IBOutlet weak var Jake5: UIImageView!
    @IBOutlet weak var Jake6: UIImageView!
    @IBOutlet weak var Jake7: UIImageView!
    @IBOutlet weak var Jake8: UIImageView!
    @IBOutlet weak var Jake9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        scoreLabel.text = "Score: \(score)"
        
        //Highscore check
        
        let storedHighscore = UserDefaults.standard.object(forKey: "Highscore")
        
        if storedHighscore == nil {
            highScore = 0
            HighscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighscore as? Int {
            highScore = newScore
            HighscoreLabel.text = "Highscore: \(highScore)"
        }
        
        //Images
        Jake1.isUserInteractionEnabled = true
        Jake2.isUserInteractionEnabled = true
        Jake3.isUserInteractionEnabled = true
        Jake4.isUserInteractionEnabled = true
        Jake5.isUserInteractionEnabled = true
        Jake6.isUserInteractionEnabled = true
        Jake7.isUserInteractionEnabled = true
        Jake8.isUserInteractionEnabled = true
        Jake9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        Jake1.addGestureRecognizer(recognizer1)
        Jake2.addGestureRecognizer(recognizer2)
        Jake3.addGestureRecognizer(recognizer3)
        Jake4.addGestureRecognizer(recognizer4)
        Jake5.addGestureRecognizer(recognizer5)
        Jake6.addGestureRecognizer(recognizer6)
        Jake7.addGestureRecognizer(recognizer7)
        Jake8.addGestureRecognizer(recognizer8)
        Jake9.addGestureRecognizer(recognizer9)
        
        jakeArray = [Jake1, Jake2, Jake3, Jake4, Jake5, Jake6, Jake7, Jake8, Jake9]
        
        
        //Timers
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideJake), userInfo: nil, repeats: true)
        hideJake()
        
        
        
    }
    
    @objc func hideJake() {
        for jake in jakeArray{
            jake.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(jakeArray.count - 1)))
        jakeArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for jake in jakeArray {
                jake.isHidden = true
            }
            //Highscore
            if self.score > self.highScore {
                self.highScore = self.score
                HighscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "Highscore")
            }
            
            
            //Alert
            let alert = UIAlertController(title: "Time's up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideJake), userInfo: nil, repeats: true)
                
                
        }
        alert.addAction(okButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
        }
    }
    
}













