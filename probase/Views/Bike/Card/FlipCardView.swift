//
//  FlipCardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/30/25.
//


import SwiftUI

struct FlipCardView: View {
    @State private var isFlipped = false

    var body: some View {
        VStack {
            ZStack {
                // Front of the card
                if !isFlipped {
                    FrontCardView()
                        .rotation3DEffect(
                            .degrees(isFlipped ? 180 : 0),
                            axis: (x: 0, y: 1, z: 0)
                        )
                }

                // Back of the card
                if isFlipped {
                    BackCardView()
                        .rotation3DEffect(
                            .degrees(isFlipped ? 0 : -180),
                            axis: (x: 0, y: 1, z: 0)
                        )
                }
            }
            .frame(width: 200, height: 300)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(16)
            .shadow(radius: 5)
            .onTapGesture {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.5)) {
                    isFlipped.toggle()
                }
            }
        }
    }
}

struct FrontCardView: View {
    var body: some View {
        VStack {
            Image(systemName: "bicycle")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
            Text("Suspension Setup")
                .font(.headline)
                .padding()
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Image(systemName: "wrench.and.screwdriver.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
            Text("Settings Applied!")
                .font(.headline)
                .padding()
        }
    }
}

#Preview {
    FlipCardView()
}

