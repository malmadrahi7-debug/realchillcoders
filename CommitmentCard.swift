//
//  CommitmentCard.swift
//  credibality
//
//  Created by Moria Almadrahi on 12/4/25.
//

import SwiftUI

struct CommitmentCard: View {
    let commitment: Commitment

    var body: some View {
        HStack {
            Text(commitment.title)
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.semibold)

            Spacer()

            ZStack {
                Circle()
                    .stroke(.white.opacity(0.25), lineWidth: 5)
                    .frame(width: 55, height: 55)

                Circle()
                    .trim(from: 0, to: commitment.progress)
                    .stroke(.white, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 55, height: 55)

                Text("\(Int(commitment.progress * 100))%")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.white.opacity(0.05))
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(.green, lineWidth: 2))
        )
        .padding(.horizontal)
    }
}
