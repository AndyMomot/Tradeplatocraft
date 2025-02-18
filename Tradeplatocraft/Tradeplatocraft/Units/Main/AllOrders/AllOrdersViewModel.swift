//
//  AllOrdersViewModel.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import Foundation

extension AllOrdersView {
    final class ViewModel: ObservableObject {
        let orderStatuses = ["Wszystko"] + OrderCostModel.Status.allCases.map { $0.displayName }
        @Published var selectedOrderStatus = "Wszystko" {
            didSet {
                Task {
                    await getItems()
                }
            }
        }
        
        @Published var orders: [OrderCostModel] = []
        var viewType: OrderCostModel.ItemType = .order
    }
}

extension AllOrdersView.ViewModel {
    func getItems() async {
        let allItems = DefaultsService.shared.ordersAndCosts
        var orders: [OrderCostModel] {
            var result = allItems.filter { $0.type == viewType }
            if let status = OrderCostModel.Status.allCases.first(where: { $0.displayName == selectedOrderStatus }) {
                result = result.filter { $0.status == status }
            }
            
            return result
        }
        
        await MainActor.run { [weak self] in
            guard let self else { return }
            self.orders = orders
        }
    }
    
    func handleOrder(action: OrderCell.ViewAction) async {
        switch action {
        case .delete(let id):
            DefaultsService.shared.ordersAndCosts.removeAll(where: { $0.id == id })
            await getItems()
        case .changeStatus(let id, let statusName):
            guard let status = OrderCostModel.Status.allCases.first(where: { $0.displayName == statusName }) else {
                await getItems()
                return
            }
            
            let shared = DefaultsService.shared
            if let index = shared.ordersAndCosts.firstIndex(where: { $0.id == id }) {
                shared.ordersAndCosts[index].status = status
                await getItems()
            }
        }
    }
}
