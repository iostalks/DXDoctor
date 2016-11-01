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
    fileprivate override init() {}
    
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
    
    func playAudio(_ name: String) {
        
        let soundURL: URL? = Bundle.main.url(forResource: name, withExtension: "caf")
        var tabSoundID: SystemSoundID = 0
        if let soundURL_ = soundURL {
            
            AudioServicesCreateSystemSoundID(soundURL_ as CFURL, &tabSoundID)
            AudioServicesPlaySystemSound(tabSoundID); // Play
        }
   
    }
    
    
}
