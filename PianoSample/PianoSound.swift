//
//  SineWave.swift
//  PianoSample
//
//  Created by Takuto Nakamura on 2020/09/11.
//  Copyright © 2020 Takuto Nakamura. All rights reserved.
//

import AVFoundation

class PianoSound {

    private let audioEngine = AVAudioEngine()
    private let unitSampler = AVAudioUnitSampler()
    private var whiteNotes = [UInt8]()
    private var blackNotes = [UInt8]()

    init(volume: Float = 0.5) {
        whiteNotes = makeWhiteNotes(14)
        blackNotes = mekeBlackNotes(13)
        audioEngine.mainMixerNode.volume = volume
        audioEngine.attach(unitSampler)
        audioEngine.connect(unitSampler, to: audioEngine.mainMixerNode, format: nil)
        if let _ = try? audioEngine.start() {
            loadSoundFont()
        }
    }

    deinit {
        if audioEngine.isRunning {
            audioEngine.disconnectNodeOutput(unitSampler)
            audioEngine.detach(unitSampler)
            audioEngine.stop()
        }
    }

    private func loadSoundFont() {
        guard let url = Bundle.main.url(forResource: "emuaps_8mb",
                                        withExtension: "sf2") else { return }
        try? unitSampler.loadSoundBankInstrument(
            at: url, program: 0,
            bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
            bankLSB: UInt8(kAUSampler_DefaultBankLSB)
        )
    }

    private func makeWhiteNotes(_ n: Int) -> [UInt8] {
        if n < 0 {
            fatalError("bad request")
        } else if n == 0 {
            return [60]
        } else if n % 7 == 0 || n % 7 == 3 {
            let notes = makeWhiteNotes(n - 1)
            return notes + [notes.last! + 1]
        } else {
            let notes = makeWhiteNotes(n - 1)
            return notes + [notes.last! + 2]
        }
    }

    private func mekeBlackNotes(_ n: Int) -> [UInt8] {
        if n < 0 {
            fatalError("bad request")
        } else if n == 0 {
            return [61]
        } else if n % 7 == 2 || n % 7 == 6 {
            let notes = mekeBlackNotes(n - 1)
            return notes + [notes.last! + 1]
        } else {
            let notes = mekeBlackNotes(n - 1)
            return notes + [notes.last! + 2]
        }
    }

    private func convert(keyInfo: KeyInfo) -> UInt8 {
        if keyInfo.color == .white {
            return UInt8(whiteNotes[keyInfo.n])
        } else {
            return UInt8(blackNotes[keyInfo.n])
        }
    }

    func play(keyInfo: KeyInfo) {
        let note = convert(keyInfo: keyInfo)
        self.unitSampler.startNote(note, withVelocity: 80, onChannel: 0)
    }

//    func fadeOut(note: UInt8, pressure: UInt8 = 80) {
//        if 0 < pressure {
//            self.unitSampler.sendPressure(forKey: note, withValue: pressure - 10, onChannel: 0)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//                self.fadeOut(note: note, pressure: pressure - 10)
//            }
//        } else {
//            self.unitSampler.stopNote(note, onChannel: 0)
//        }
//    }

    func stop(keyInfo: KeyInfo) {
        let note = convert(keyInfo: keyInfo)
        self.unitSampler.stopNote(note, onChannel: 0)
    }

}
