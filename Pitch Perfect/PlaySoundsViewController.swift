//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Amelia Boli on 3/16/16.
//  Copyright © 2016 Amelia Boli. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            audioPlayer.enableRate = true
        } catch {
            print("Error with audioPlayer")
        }
        
        audioEngine = AVAudioEngine()
        do {
             audioFile = try AVAudioFile(forReading: receivedAudio.filePathUrl)
        } catch {
            print("Error with audioFile")
        }
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        playAudio(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudio(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithEffects(1000, reverb: 0, echo: 0)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithEffects(-1000, reverb: 0, echo: 0)
    }
    
    @IBAction func playEchoAudio(sender: UIButton) {
        playAudioWithEffects(1, reverb: 0, echo: 0.2)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        playAudioWithEffects(1, reverb: 50, echo: 0)
    }
    
    @IBAction func stopAudio(sender: UIButton?) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

    func playAudio(rate: Float) {
        stopAudio(nil)
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithEffects(pitch: Float, reverb: Float, echo: Float) {
        stopAudio(nil)
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let pitchEffect = AVAudioUnitTimePitch()
        pitchEffect.pitch = pitch
        audioEngine.attachNode(pitchEffect)
        
        //The code for echo and reverb were taken off of this github site: https://github.com/anthonymonori/PitchPerfect-iOS/blob/master/Pitch%20Perfect/PlaySoundsViewController.swift. I then spent hours looking at ways to consolidate all of the AVAudioEngine effects into one function. My solution is very similar to the function at the above site because I determined it was the best option with my knowledge.
        
        let echoEffect = AVAudioUnitDelay()
        echoEffect.delayTime = NSTimeInterval(echo)
        audioEngine.attachNode(echoEffect)
        
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        reverbEffect.wetDryMix = reverb
        audioEngine.attachNode(reverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: pitchEffect, format: nil)
        audioEngine.connect(pitchEffect, to: echoEffect, format: nil)
        audioEngine.connect(echoEffect, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch {
            print("Error with audioEngine start")
        }
        audioPlayerNode.play()
    }
}
