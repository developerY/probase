//
//  NFTDetailView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/28/25.
//
import SwiftUI

struct NFTDetailView: View {
    let nft: NFTItem
    
    var body: some View {
        VStack(spacing: 20) {
            Text(nft.name)
                .font(.largeTitle.bold())
            
            AsyncImage(url: nft.imageURL) { imagePhase in
                switch imagePhase {
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
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 300)
            .cornerRadius(16)
            
            // "Trade" or "Send" button
            Button("Send to Another Wallet") {
                // Example: present a UI to enter recipient address,
                // then call web3 code to transfer token ID
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Spacer()
        }
        .padding()
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    let sampleNFT = NFTItem(
        tokenID: "67890",
        contractAddress: "0xdef456789abc",
        name: "Legendary Phoenix",
        imageURL: URL(string: "https://via.placeholder.com/300")!  // Replace with actual image URL
    )
    
    NFTDetailView(nft: sampleNFT)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.7), .blue.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
}
