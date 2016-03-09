//
//  ViewController.swift
//  BullsEye
//
//  Created by JohnBryant on 16/3/6.
//  Copyright © 2016年 JohnBryant. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var startOver: UIButton!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 50
    var score = 0
    var round = 0
    var targetValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        startNewGame()
        updateLables()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(currentValue - targetValue)
        var point = 100 - difference
        let title: String
        if difference==0 {
            title = "Perfect!"
            point += 100
        } else if difference < 5 {
            title = "You almost have it!"
            if difference == 1 {
                point += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close.."
        }
        score += point
        let message = "you scored \(point) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: { action in
                                                                            self.startNewRound()
                                                                            self.updateLables()})
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(sender: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver(sender: UIButton) {
        startNewGame()
        updateLables()
        
//        let transition = CATransaction()
//        transition.type = kCATransitionFade
//        transition.duration = 1
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//        view.layer.addAnimation(transition, forKey: nil)
    }
    
    
    func startNewRound() {
        round+=1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLables() {
        targetValueLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
}

