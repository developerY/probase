//
//  NFTLibraryViewModel.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/28/25.
//
import SwiftUI

@MainActor
class NFTLibraryViewModel: ObservableObject {
    @Published var nftItems: [NFTItem] = []
    @Published var isLoading = false
    
    // For detail sheet
    @Published var selectedNFT: NFTItem? = nil
    @Published var showDetail = false
    
    // Replace with your actual user/wallet ID or handle
    private let walletAddress = "0x1234..."
    
    func fetchNFTs() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // This is a placeholder for a real Web3 or API call
            let items = try await fetchUserNFTs(for: walletAddress)
            nftItems = items
        } catch {
            print("Error fetching NFTs: \(error)")
        }
    }
    
    /// Example placeholder for fetching user NFTs
    private func fetchUserNFTs(for walletAddress: String) async throws -> [NFTItem] {
        // --- Example: call Alchemy, OpenSea, or your own API
        // let fetchedData = try await MyNFTService.shared.getNFTs(for: walletAddress)
        // Convert fetched data to NFTItem array.
        
        // Hardcoding sample data for demonstration:
        return [
            NFTItem(
                tokenID: "1",
                contractAddress: "0xABCD...",
                name: "Earth Guardian",
                imageURL: URL(string: "https://example.com/nft/earth-guardian.png")!
            ),
            NFTItem(
                tokenID: "2",
                contractAddress: "0xABCD...",
                name: "Green Avenger",
                imageURL: URL(string: "https://example.com/nft/green-avenger.png")!
            )
        ]
    }
}
