//
//  ContentView.swift
//  PianoSample
//
//  Created by Takuto Nakamura on 2020/09/10.
//  Copyright © 2020 Takuto Nakamura. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var location: CGPoint = .zero
    let model = SoundModel()

    var body: some View {
        let drag = DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
            .onChanged({ drag in
                self.location = drag.location
            })
            .onEnded({ _ in
                self.location = .zero
            })

        return ZStack(alignment: .top) {
            // white keys
            HStack(spacing: 2) {
                ForEach(0 ..< 8) { n in
                    self.whiteKeys(n: n)
                }
            }
            // black keys
            HStack(spacing: 18) {
                ForEach(0 ..< 7) { n in
                    self.blackKeys(n: n)
                }
            }
        }
        .padding(20)
        .background(Color.gray)
        .gesture(drag)
    }
    
    private func whiteKeys(n: Int) -> some View {
        let view: PianoKeyView
        switch n {
        case 0, 3:
            let model = PianoKeyModel(color: .white, type: .left, n: n)
            view = PianoKeyView(model: model, location: self.$location)
        case 1, 4, 5:
            let model = PianoKeyModel(color: .white, type: .center, n: n)
            view = PianoKeyView(model: model, location: self.$location)
        case 2, 6:
            let model = PianoKeyModel(color: .white, type: .right, n: n)
            view = PianoKeyView(model: model, location: self.$location)
        default:
            let model = PianoKeyModel(color: .white, type: .plain, n: n)
            view = PianoKeyView(model: model, location: self.$location)
        }
        return view.onEvent(handler: { (keyInfo) in
            self.model.called(keyInfo: keyInfo)
        })
    }

    private func blackKeys(n: Int) -> some View {
        if n == 2 || n == 6 {
            let model = PianoKeyModel(color: .clear, type: .plain, n: n)
            return PianoKeyView(model: model, location: self.$location)
                .onEvent { _ in }
        } else {
            let model = PianoKeyModel(color: .black, type: .plain, n: n)
            return PianoKeyView(model: model, location: self.$location)
                .onEvent(handler: { (keyInfo) in
                    self.model.called(keyInfo: keyInfo)
                })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
