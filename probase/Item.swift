//
//  Item.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/25/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
