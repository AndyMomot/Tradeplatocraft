//
//  StatisticsViewModel.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 18.02.2025.
//

import Foundation

extension StatisticsView {
    final class ViewModel: ObservableObject {
        let itemTypes = OrderCostModel.ItemType.allCases.map { $0.displayName }
        @Published var selectedOrderStatus = OrderCostModel.ItemType.order.displayName
        @Published var items: [OrderCostModel] = []
    }
}

extension StatisticsView.ViewModel {
    func getItems() async {
        let allItems = DefaultsService.shared.ordersAndCosts
        
        var items: [OrderCostModel] {
            guard let type = OrderCostModel.ItemType.allCases.first(where: {
                $0.displayName == selectedOrderStatus
            }) else { return [] }
            
            return allItems.filter { $0.type == type }
        }
        
        await MainActor.run { [weak self] in
            guard let self else { return }
            self.items.removeAll()
            self.items = items
        }
    }
}
