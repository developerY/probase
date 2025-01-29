//
//  NFTCardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/28/25.
//
import SwiftUI

struct NFTCardView: View {
    let nft: NFTItem
    
    var body: some View {
        ZStack {
            // Background swirl (semi-transparent)
            Image("swirlGraphic")      // Replace with your actual asset name
                .resizable()
                .scaledToFit()
                .opacity(0.1)         // Subtle transparency
                .rotationEffect(.degrees(15))
                .offset(x: 30, y: 40) // Slight offset to look appealing
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Main content (image + name)
            VStack {
                AsyncImage(url: nft.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(20)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(8)
                .frame(height: 120)

                Text(nft.name)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
            
            // Overlay icon in top-right corner
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "star.fill") // or your chosen icon
                        .foregroundColor(.yellow)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(Color.black.opacity(0.2))
                        )
                        .padding([.top, .trailing], 8)
                }
                Spacer()
            }
        }
        // Frosted or tinted background
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.thinMaterial)
        )
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}


