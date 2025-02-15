//
//  HomeViewModel.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import Foundation

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var balance = 0
        @Published var income = 0
        @Published var costs = 0
        
        @Published var ordersAndCostsItems: [OrderCostModel] = []
    }
}

extension HomeView.ViewModel {
    func getOrdersAndCosts() async {
        let allItems = DefaultsService.shared.ordersAndCosts
        let orderItems = allItems.filter { $0.type == .order}
        let costItems = allItems.filter { $0.type == .cost}
        
        let balance = allItems.map { $0.price }.reduce(0) { $0 + $1 }
        let income = orderItems.map { $0.price }.reduce(0) { $0 + $1 }
        let costs = costItems.map { $0.price }.reduce(0) { $0 + $1 }
        
        await MainActor.run { [weak self] in
            guard let self else { return }
            self.balance = balance
            self.income = income
            self.costs = costs
            self.ordersAndCostsItems = allItems
        }
    }
    
    func addTestItem(withType type: OrderCostModel.ItemType) async {
        let item = OrderCostModel(
            type: type,
            name: "Item \(UUID().uuidString.prefix(10))",
            date: .init(),
            price: .random(in: 100...10_000)
        )
        
        DefaultsService.shared.ordersAndCosts.append(item)
        await getOrdersAndCosts()
    }
}
