//
//  NFTLibraryView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/28/25.
//
import SwiftUI

struct NFTLibraryView: View {
    @StateObject private var viewModel = NFTLibraryViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient, if desired
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.green.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("My Earth-Saving NFTs")
                            .font(.largeTitle.bold())
                            .padding(.top, 20)
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                        
                        if viewModel.isLoading {
                            ProgressView("Loading NFTs...")
                                .tint(.white)
                                .padding()
                        } else if viewModel.nftItems.isEmpty {
                            Text("No NFTs yet. Earn them by completing challenges!")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                                .padding()
                        } else {
                            // Display NFTs in a grid or list
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                                ForEach(viewModel.nftItems) { nft in
                                    NFTCardView(nft: nft)
                                        .onTapGesture {
                                            // Possibly navigate to a detail view
                                            viewModel.selectedNFT = nft
                                            viewModel.showDetail = true
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 30)
                    }
                }
                .sheet(item: $viewModel.selectedNFT) { nft in
                    NFTDetailView(nft: nft)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.purple.opacity(0.7), .blue.opacity(0.7)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
            }
            .navigationTitle("NFT Library")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            // Load NFTs on appear
            await viewModel.fetchNFTs()
        }
    }
}


#Preview {
    let viewModel = NFTLibraryViewModel()
    viewModel.nftItems = [
        NFTItem(tokenID: "1", contractAddress: "0xABCD", name: "Eco Hero", imageURL: URL(string: "https://via.placeholder.com/150")!),
        NFTItem(tokenID: "2", contractAddress: "0xEFGH", name: "Nature Guardian", imageURL: URL(string: "https://via.placeholder.com/150")!)
    ]
    
    return NFTLibraryView()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.7), .blue.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .environmentObject(viewModel)
}
