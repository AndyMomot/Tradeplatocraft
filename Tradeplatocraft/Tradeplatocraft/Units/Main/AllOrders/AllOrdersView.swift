//
//  AllOrdersView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import SwiftUI

struct AllOrdersView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.darkGreen
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                NavigationBarTitle(text: "Wszystkie zamówienia")
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
                await viewModel.getOrders()
            }
        }
    }
}

#Preview {
    AllOrdersView()
}
