//
//  KeyShape.swift
//  PianoSample
//
//  Created by Takuto Nakamura on 2020/09/10.
//  Copyright © 2020 Takuto Nakamura. All rights reserved.
//

import SwiftUI

struct KeyShape: Shape {
    var radius: CGFloat = 0.0
    var type: KeyType = .plain

    func path(in rect: CGRect) -> Path {
        let w = rect.size.width
        let h = rect.size.height
        let r = min(radius, min(w / 2, h / 2))
        var path = Path()
        path.move(to: CGPoint(x: w, y: h - r))
        path.addArc(center: CGPoint(x: w - r, y: h - r),
                    radius: r,
                    startAngle: Angle(radians: 0),
                    endAngle: Angle(radians: .pi / 2),
                    clockwise: false)
        path.addLine(to: CGPoint(x: r, y: h))
        path.addArc(center: CGPoint(x: r, y: h - r),
                    radius: r,
                    startAngle: Angle(radians: .pi / 2),
                    endAngle: Angle(radians: .pi),
                    clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: h * 3 / 5))
        if type == .plain || type == .left {
            path.addLine(to: CGPoint(x: 0, y: 0))
        } else {
            path.addLine(to: CGPoint(x: w / 3, y: h * 3 / 5))
        }
        path.addLine(to: CGPoint(x: w / 3, y: 0))
        path.addLine(to: CGPoint(x: w * 2 / 3, y: 0))
        if type == .plain || type == .right {
            path.addLine(to: CGPoint(x: w, y: 0))
        } else {
            path.addLine(to: CGPoint(x: w * 2 / 3, y: h * 3 / 5))
        }
        path.addLine(to: CGPoint(x: w, y: h * 3 / 5))
        path.closeSubpath()
        return path
    }

    func invertPath(in rect: CGRect) -> Path {
        return self.path(in: rect)
            .transform(CGAffineTransform(scaleX: 1, y: -1))
            .transform(CGAffineTransform(translationX: 0, y: rect.height))
            .path(in: rect)
    }
}
