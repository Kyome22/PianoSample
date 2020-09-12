//
//  PianoModel.swift
//  PianoSample
//
//  Created by Takuto Nakamura on 2020/09/10.
//  Copyright © 2020 Takuto Nakamura. All rights reserved.
//

import Foundation

class SoundModel {

    let piano = PianoSound()

    func called(keyInfo: KeyInfo) {
        Swift.print(keyInfo.description)
        if keyInfo.isPressed {
            piano.play(keyInfo: keyInfo)
        } else {
            piano.stop(keyInfo: keyInfo)
        }
    }

}

