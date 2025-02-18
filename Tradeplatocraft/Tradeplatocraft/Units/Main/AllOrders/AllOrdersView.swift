//
//  AllOrdersView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import SwiftUI

struct AllOrdersView: View {
    let viewType: OrderCostModel.ItemType
    @StateObject private var viewModel = ViewModel()
    
    init(viewType: OrderCostModel.ItemType, viewModel: ViewModel = ViewModel()) {
        self.viewType = viewType
        viewModel.viewType = viewType
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.darkGreen
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                let title = viewType == .order ? "Wszystkie zamówienia" : "Wszystkie wydatek"
                NavigationBarTitle(text: title)
                    .padding(.horizontal)
                
                HorisontalPicker(
                    items: viewModel.orderStatuses,
                    scrollHorizontalPadding: 16,
                    selection: $viewModel.selectedOrderStatus
                )
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.orders) { order in
                            OrderCell(item: order) { action in
                                Task {
                                    await viewModel.handleOrder(action: action)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getItems()
            }
        }
    }
}

#Preview {
    AllOrdersView(viewType: .order)
}

#Preview {
    AllOrdersView(viewType: .cost)
}
