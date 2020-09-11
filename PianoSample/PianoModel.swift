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
    let sineWave = SineWave()

    init() {
        subject.sink { (info) in
            self.called(keyInfo: info)
        }
        .store(in: &cancellables)
    }

    func called(keyInfo: KeyInfo) {
        if keyInfo.isPressed {
            sineWave.play(keyInfo: keyInfo)
        } else {
            sineWave.stop(keyInfo: keyInfo)
        }

        Swift.print(keyInfo.description)
    }

}

