//
//  PianoKeyView.swift
//  PianoSample
//
//  Created by Takuto Nakamura on 2020/09/10.
//  Copyright © 2020 Takuto Nakamura. All rights reserved.
//

import SwiftUI

struct PianoKeyView: View {

    let model: PianoKeyModel
    @Binding var location: CGPoint

    init(model: PianoKeyModel, location: Binding<CGPoint>) {
        self.model = model
        _location = location
    }

    var body: some View {
        let size = getSize()
        return GeometryReader { geometry in
            self.makeShape(geometry: geometry)
        }
        .frame(width: size.width, height: size.height)
    }

    private func getSize() -> CGSize {
        let w: CGFloat = model.color == .white ? 40 : 24
        let h: CGFloat = model.color == .white ? 200 : 119
        return CGSize(width: w, height: h)
    }

    private func hit(geometry: GeometryProxy) -> Bool {
        let frame = geometry.frame(in: .global)
        let path = KeyShape(radius: 8, type: model.type)
            .invertPath(in: CGRect(origin: .zero, size: frame.size))
        return path.contains(CGPoint(x: location.x - frame.origin.x,
                                     y: location.y - frame.origin.y))
    }

    private func makeShape(geometry: GeometryProxy) -> some View {
        self.model.isHit = hit(geometry: geometry)
        return KeyShape(radius: 8, type: model.type)
            .fill(model.getColor())
    }

    func onEvent(handler: @escaping ((KeyInfo) -> Void)) -> some View {
        return self.onReceive(model.subject, perform: { (keyInfo) in
            handler(keyInfo)
        })
    }
}

struct PianoKeyView_Previews: PreviewProvider {
    static var previews: some View {
        let model = PianoKeyModel(color: .white, type: .plain, n: 0)
        return PianoKeyView(model: model, location: .constant(.zero))
    }
}
