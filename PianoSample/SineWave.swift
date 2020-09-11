//
//  SineWave.swift
//  PianoSample
//
//  Created by Takuto Nakamura on 2020/09/11.
//  Copyright © 2020 Takuto Nakamura. All rights reserved.
//

import AVFoundation

class SineWave {

    let audioEngine = AVAudioEngine()
    let unitSampler = AVAudioUnitSampler()
    var cnt: Int = 0

    init(volume: Float = 0.5) {
        audioEngine.mainMixerNode.volume = volume
        audioEngine.attach(unitSampler)
        audioEngine.connect(unitSampler, to: audioEngine.mainMixerNode, format: nil)
        try? audioEngine.start()
    }

    deinit {
        if audioEngine.isRunning {
            audioEngine.disconnectNodeOutput(unitSampler)
            audioEngine.detach(unitSampler)
            audioEngine.stop()
        }
    }

    func convert(keyInfo: KeyInfo) -> UInt8 {
        switch (keyInfo.color, keyInfo.n) {
        case (.white, 0): return 60
        case (.black, 0): return 61
        case (.white, 1): return 62
        case (.black, 1): return 63
        case (.white, 2): return 64
        case (.white, 3): return 65
        case (.black, 3): return 66
        case (.white, 4): return 67
        case (.black, 4): return 68
        case (.white, 5): return 69
        case (.black, 5): return 70
        case (.white, 6): return 71
        case (.white, 7): return 72
        default: return 60
        }
    }

    func play(keyInfo: KeyInfo) {
        let note = convert(keyInfo: keyInfo)
        self.unitSampler.startNote(note, withVelocity: 70, onChannel: 0)
    }

    func stop(keyInfo: KeyInfo) {
        let note = convert(keyInfo: keyInfo)
        self.unitSampler.stopNote(note, onChannel: 0)
    }

}
