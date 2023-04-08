//
//  ViewController.swift
//  catch-kenny
//
//  Created by Edanur Oner on 8.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var highscore = 0
    var counter = 0
    var timer = Timer()
    var kennyTimer = Timer()
    var firstLocation = CGRect()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var kenny: UIImageView!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLocation = kenny.frame
        counter = 10
        timeLabel.text = "Time: \(counter)"
                
        timer = Timer.scheduledTimer(
        timeInterval: 1,
        target: self,
        selector: #selector(timerFunction),
        userInfo: nil, repeats: true)
        
        kennyTimer = Timer.scheduledTimer(
        timeInterval: 0.4,
        target: self,
        selector: #selector(kennyTimerFunction),
        userInfo: nil, repeats: true)

        
        kenny.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        kenny.addGestureRecognizer(gestureRecognizer)
        
        highscore = UserDefaults.standard.integer(forKey: "highscore")
        highscoreLabel.text = "Highscore: \(highscore)"
    
    }
    
    
    
    @IBAction func replayClicked(_ sender: Any) {
        replayKenny()
    }
    
    
    
    @IBAction func resetClicked(_ sender: Any) {
        resetKenny()
    }
    
    @objc func changeKenny() {
        
        score = score + 1
        scoreLabel.text = "Score: \(score)"

        if(score > highscore){
            highscore = score
            UserDefaults.standard.set(highscore, forKey: "highscore")
            highscoreLabel.text = "Highscore: \(highscore)"
        }
            
    }
    
    @objc func timerFunction() {
            
            timeLabel.text = "Time: \(counter)"
            counter -= 1
                    if counter == 0 {
                kennyTimer.invalidate()
                timer.invalidate()
                timeLabel.text = "Time's Over"
                resetKenny()
                
            }
            
            
        }
    
    @objc func kennyTimerFunction() {
            
          changeKennyLocation()
          
           if counter == 0 {
               
             timer.invalidate()
             kennyTimer.invalidate()
             resetKenny()
        }
            
            
        }
    
    func changeKennyLocation(){
        let minX = Int(kenny.frame.width / 2.0)
        let minY = Int(kenny.frame.height / 2.0)
        let maxX = Int((self.view.bounds.width - kenny.frame.width))
        let maxY = Int((self.view.bounds.height - kenny.frame.height))
       let randomY = Int.random(in: minY..<maxY)
       let randomX = Int.random(in: minX..<maxX)
       
       
       kenny.frame = CGRect(
           x: randomX,
           y: randomY,
           width: Int(kenny.frame.width),
           height: Int(kenny.frame.height))
           }
    
    func resetKenny(){
        
        counter = 10
        score = 0
        
        kenny.frame = firstLocation
        scoreLabel.text = "Score: 0"
        timeLabel.text = "Time: 0"
        kennyTimer.invalidate()
        timer.invalidate()
        
        kenny.isUserInteractionEnabled = false
    }
    
    func replayKenny() {
        
        kenny.isUserInteractionEnabled = true
        score = 0
        counter = 10
        timeLabel.text = "Time: \(counter)"
                
        timer = Timer.scheduledTimer(
        timeInterval: 1,
        target: self,
        selector: #selector(timerFunction),
        userInfo: nil, repeats: true)
        
        kennyTimer = Timer.scheduledTimer(
        timeInterval: 0.4,
        target: self,
        selector: #selector(kennyTimerFunction),
        userInfo: nil, repeats: true)

        
        highscore = UserDefaults.standard.integer(forKey: "highscore")
        highscoreLabel.text = "Highscore: \(highscore)"

    
        
    }
}
