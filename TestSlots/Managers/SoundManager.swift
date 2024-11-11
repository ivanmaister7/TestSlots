//
//  SoundManager.swift
//  TestSlots
//
//  Created by ivan on 11.11.2024.
//

import AVFoundation
import UIKit

class SoundManager {
    
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        setupAudioSession()
        setupObservers()
        
        if StorageManager.defaults.getIsSoundOn() ?? false {
            playSound()
        }
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }
    
    func playSound() {
        if let soundURL = Bundle.main.url(forResource: "test", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
                audioPlayer?.play()
            } catch {
                print("Failed to play sound: \(error)")
            }
        }
    }
    
    func stopSound() {
        audioPlayer?.pause()
    }
    
    // MARK: - Observers for App Lifecycle Events
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func handleAppDidEnterBackground() {
        stopSound()
    }
    
    @objc private func handleAppWillEnterForeground() {
        if StorageManager.defaults.getIsSoundOn() ?? false {
            audioPlayer?.play()
        }
    }
}
