//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        // log btn title to console
        print(sender.currentTitle!)
        
        // log btns opacity
        print(sender.alpha)
        
        // change opacity of pressed btn to half
        sender.alpha = 0.5
        
        // after a 2s revert opacity
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
        
        // call playSound function with currentTitle
        playSound(soundName: sender.currentTitle!)
    }
    
    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    

}

