//
//  NFTItem.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/28/25.
//
import Foundation

struct NFTItem: Identifiable {
    let id = UUID()
    let tokenID: String
    let contractAddress: String
    let name: String
    let imageURL: URL
    // Additional metadata if needed, e.g. description, rarity, etc.
}
