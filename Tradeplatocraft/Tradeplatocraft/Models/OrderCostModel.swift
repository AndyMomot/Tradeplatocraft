//
//  OrderCostModel.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import Foundation

struct OrderCostModel: Codable, Identifiable, Hashable {
    private(set) var id = UUID().uuidString
    let type: ItemType
    let name: String
    let date: Date
    let price: Int
    var status: Status = .inProgress
}

extension OrderCostModel {
    enum ItemType: Codable {
        case order, cost
    }
    
    enum Status: Codable {
        case inProgress
        case completed
        case canceled
    }
}
