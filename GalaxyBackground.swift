//
//  GalaxyBackground.swift
//  credibality
//
//  Created by Moria Almadrahi on 12/4/25.
//

import SwiftUI

struct GalaxyBackground: View {
    var body: some View {
        GeometryReader { geo in
            Image("galaxy")
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
                .overlay(Color.black.opacity(0.55))
                .overlay(
                    LinearGradient(
                        colors: [.purple.opacity(0.25), .black.opacity(0.7)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}
