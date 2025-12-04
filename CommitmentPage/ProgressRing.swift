//
//  ProgressRing.swift
//  credibality
//
//  Created by Moria Almadrahi on 12/4/25.
//

import SwiftUI

struct ProgressRing: View {
    let progress: Double
    let color: Color
    let size: CGFloat

    var body: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                color,
                style: StrokeStyle(
                    lineWidth: 22,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(-90))
            .frame(width: size, height: size)
            .animation(.easeInOut, value: progress)
    }
}
