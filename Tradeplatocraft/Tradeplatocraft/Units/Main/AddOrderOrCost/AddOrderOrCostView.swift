//
//  AddOrderOrCostView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct AddOrderOrCostView: View {
    let viewType: OrderCostModel.ItemType
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ViewModel()
    
    init(viewType: OrderCostModel.ItemType, viewModel: ViewModel = .init()) {
        self.viewType = viewType
        viewModel.viewType = viewType
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.darkGreen
                .ignoresSafeArea()
            
            TabView(selection: $viewModel.currentState) {
                AddOrderOrCostViewContainer(title: viewModel.title) {
                    Text("First Content")
                } action: { action in
                    Task {
                        await viewModel.handleContainer(action: action)
                    }
                }
                .tag(ViewState.first)
                
                AddOrderOrCostViewContainer(title: viewModel.title) {
                    Text("Second Content")
                } action: { action in
                    Task {
                        await viewModel.handleContainer(action: action)
                    }
                }
                .tag(ViewState.second)
                
                AddOrderOrCostViewContainer(title: viewModel.title) {
                    Text("Third Content")
                } action: { action in
                    Task {
                        await viewModel.handleContainer(action: action)
                    }
                }
                .tag(ViewState.third)
                
                Text("Success Content")
                    .tag(ViewState.success)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
        }
        .onAppear {
            Task {
                await viewModel.setTitle()
            }
        }
    }
}

#Preview {
    AddOrderOrCostView(viewType: .order)
}
