//
//  RingsView.swift
//  credibality
//
//  Created by Moria Almadrahi on 12/4/25.
//

import SwiftUI

struct RingsView: View {
    let commitments: [Commitment]

    var body: some View {
        ZStack {
            ForEach(commitments.indices, id: \.self) { i in
                let size = CGFloat(250 - (i * 50))
                let colors: [Color] = [.green, .purple, .white, .pink, .blue]
                let ringColor = colors[i % colors.count]

                ProgressRing(
                    progress: commitments[i].progress,
                    color: ringColor,
                    size: size
                )
            }

            Image("profilePic")
                .resizable()
                .frame(width: 65, height: 90)
                .clipShape(Circle())
                .shadow(radius: 15)
        }
        .padding(.top, 70)
    }
}
