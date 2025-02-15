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
                    AddOrderOrCostFirstView(
                        name: $viewModel.name,
                        date: $viewModel.date
                    )
                } action: { action in
                    Task {
                        await viewModel.handleContainer(action: action)
                    }
                }
                .tag(ViewState.first)
                
                AddOrderOrCostViewContainer(title: viewModel.title) {
                    AddOrderOrCostSecondView(
                        image: $viewModel.uiImage,
                        price: $viewModel.price
                    )
                } action: { action in
                    Task {
                        await viewModel.handleContainer(action: action)
                    }
                }
                .tag(ViewState.second)
                
                AddOrderOrCostViewContainer(title: viewModel.title) {
                    AddOrderOrCostThirdView(
                        image: viewModel.uiImage,
                        name: viewModel.name,
                        price: viewModel.price,
                        date: viewModel.date)
                } action: { action in
                    Task {
                        await viewModel.handleContainer(action: action)
                    }
                }
                .tag(ViewState.third)
                
                AddOrderOrCostSuccessView {
                    dismiss.callAsFunction()
                }
                    .tag(ViewState.success)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .animation(.easeInOut, value: viewModel.currentState)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                await viewModel.setTitle()
            }
        }
        .onReceive(viewModel.onDismissSubj) {
            dismiss.callAsFunction()
        }
    }
}

#Preview {
    AddOrderOrCostView(viewType: .order)
}
