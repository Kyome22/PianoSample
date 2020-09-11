//
//  PianoKeyModel.swift
//  PianoSample
//
//  Created by Takuto Nakamura on 2020/09/11.
//  Copyright © 2020 Takuto Nakamura. All rights reserved.
//

import SwiftUI
import Combine

enum KeyColor {
    case white
    case black

    var description: String {
        switch self {
        case .white: return "white"
        case .black: return "black"
        }
    }

    func value(isHit: Bool) -> Color {
        switch self {
        case .white: return isHit ? Color(white: 0.8) : .white
        case .black: return isHit ? Color(white: 0.2) : .black
        }
    }
}

enum KeyType {
    case plain
    case left
    case center
    case right

    var description: String {
        switch self {
        case .plain: return "plain"
        case .left: return "left"
        case .center: return "center"
        case .right: return "right"
        }
    }
}

struct KeyInfo {
    let color: KeyColor
    let type: KeyType
    let n: Int
    let isPressed: Bool

    var description: String {
        return "\(color.description), \(type.description), \(n): \(isPressed)"
    }
}

class PianoKeyModel: ObservableObject {

    let subject = PassthroughSubject<KeyInfo, Never>()
    let color: KeyColor
    let type: KeyType
    let n: Int
    var isHit: Bool = false {
        didSet {
            if oldValue != isHit {
                if isHit {
                    play()
                } else {
                    stop()
                }
            }
        }
    }

    init(color: KeyColor, type: KeyType, n: Int) {
        self.color = color
        self.type = type
        self.n = n
    }

    private func play() {
        subject.send(KeyInfo(color: color, type: type, n: n, isPressed: true))
    }

    private func stop() {
        subject.send(KeyInfo(color: color, type: type, n: n, isPressed: false))
    }

    func getColor() -> Color {
        return color.value(isHit: isHit)
    }

}
