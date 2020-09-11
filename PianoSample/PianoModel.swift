//
//  PianoModel.swift
//  PianoSample
//
//  Created by Takuto Nakamura on 2020/09/10.
//  Copyright © 2020 Takuto Nakamura. All rights reserved.
//

import Foundation
import Combine

class SoundModel {

    var cancellables = Set<AnyCancellable>()
    let subject = PassthroughSubject<KeyInfo, Never>()
    let piano = PianoSound()

    init() {
        subject.sink { (info) in
            self.called(keyInfo: info)
        }
        .store(in: &cancellables)
    }

    func called(keyInfo: KeyInfo) {
        if keyInfo.isPressed {
            piano.play(keyInfo: keyInfo)
        } else {
            piano.stop(keyInfo: keyInfo)
        }

        Swift.print(keyInfo.description)
    }

}

