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
            .frame(height: 120)
            .cornerRadius(8)
            
            Text(nft.name)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 4)
    }
}

