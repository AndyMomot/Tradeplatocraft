//
//  OrderCostModel.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import Foundation

struct OrderCostModel: Codable, Identifiable, Hashable, Equatable {
    private(set) var id = UUID().uuidString
    let type: ItemType
    let name: String
    let date: Date
    let price: Int
    var status: Status = .inProgress
}

extension OrderCostModel {
    enum ItemType: Codable, CaseIterable, Equatable {
        case order, cost
        
        var displayName: String {
            switch self {
            case .order:
                return "zamówienie"
            case .cost:
                return "wydatek"
            }
        }
    }
    
    enum Status: Codable, CaseIterable, Equatable {
        case inProgress
        case completed
        case canceled
        
        var displayName: String {
            switch self {
            case .inProgress:
                return "W toku"
            case .completed:
                return "Zrobione"
            case .canceled:
                return "Odwołany"
            }
        }
    }
}
