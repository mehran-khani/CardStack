//
//  CardView.swift
//
//  Created by Mehran Khani on 22.04.2025.
//
import SwiftUI

struct CardView: View {
    let card: Card
    let position: CGSize
    let isOnTop: Bool
    @State private var isFlipped = false

    var body: some View {
        ZStack {
            CardFace(color: card.color)
                .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))

            CardFace(color: card.color)
                .rotation3DEffect(.degrees(isFlipped ? 0 : -180), axis: (x: 0, y: 1, z: 0))
        }
        .offset(position)
        .onTapGesture {
            withAnimation(.spring(response: 1.2, dampingFraction: 0.6)) {
                isFlipped.toggle()
            }
        }
    }
}

struct CardFace: View {
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(color)
            .frame(width: 250, height: 350)
            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: -8)
    }
}
