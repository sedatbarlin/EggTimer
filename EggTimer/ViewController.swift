//
//  ViewController.swift
//  EggTimer
//
//  Created by Sedat on 2.07.2023.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController {
    @IBOutlet private weak var progressBar: UIProgressView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction private func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
