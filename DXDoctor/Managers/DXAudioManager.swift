//
//  DXAudioManager.swift
//  DXDoctor
//
//  Created by Jone on 16/3/20.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit
import AVFoundation

class DXAudioManager: NSObject {

    static let manager = DXAudioManager()
    
    // This prevents others form using default '()' initializer for this class
    private override init() {}
    
    func playRefreshPullAudio() {
        playAudio("refreshing")
    }
    
    func playRefreshSuccessAudio() {
        playAudio("load_success")
    }
    
    func playRefreshFailureAudio() {
        playAudio("load_failure")
    }
    
    func playTabBabAudio() {
        playAudio("tapped")
    }
    
    func playAudio(name: String) {
        
        let soundURL: NSURL? = NSBundle.mainBundle().URLForResource(name, withExtension: "caf")
        var tabSoundID: SystemSoundID = 0
        if let soundURL_ = soundURL {
            
            AudioServicesCreateSystemSoundID(soundURL_, &tabSoundID)
            AudioServicesPlaySystemSound(tabSoundID); // Play
        }
   
    }
    
    
}
