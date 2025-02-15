//
//  HomeView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.darkGreen
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    NavigationBarTitle(text: "Panel sterowania")
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            BalanceView(value: viewModel.balance)
                            
                            IncomeCostsCompareBarChart(
                                income: viewModel.income,
                                costs: viewModel.costs
                            )
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Zobacz więcej")
                                    .foregroundStyle(.sunsetOrange)
                                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
                                
                                ScrollView(.horizontal) {
                                    HStack(spacing: 10) {
                                        AddButton(title: "Nowe zamówienie") {
                                            Task {
                                                await viewModel.addTestItem(withType: .order)
                                            }
                                        }
                                        
                                        AddButton(title: "Nowy wydatek") {
                                            Task {
                                                await viewModel.addTestItem(withType: .cost)
                                            }
                                        }
                                    }
                                }
                                .scrollIndicators(.never)
                            }
                            
                            ForEach(viewModel.ordersAndCostsItems) { item in
                                NavigationLink(value: item) {
                                    IncomeCostCell(item: item)
                                }
                            }
                        }
                        .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                    }
                    .scrollIndicators(.never)
                }
                .padding(.horizontal)
            }
            .onAppear {
                Task {
                    await viewModel.getOrdersAndCosts()
                }
            }
            .navigationDestination(for: OrderCostModel.self) { item in
                Text(item.name)
            }
        }
    }
}

#Preview {
    HomeView()
}
