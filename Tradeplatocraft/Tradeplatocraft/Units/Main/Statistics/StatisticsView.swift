//
//  StatisticsView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 18.02.2025.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.darkGreen
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                NavigationBarTitle(text: "Statystyka finansowa")
                    .padding(.horizontal)
                
                HorisontalPicker(
                    items: viewModel.itemTypes,
                    scrollHorizontalPadding: 16,
                    selection: $viewModel.selectedOrderStatus
                )
                
                ScrollView {
                    if !viewModel.items.isEmpty {
                        StatisticChart(items: viewModel.items)
                            .padding(.horizontal)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                            .transition(AnyTransition.scale.animation(.easeInOut))
                    } else {
                        Text("Nie znaleziono elementów")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getItems()
            }
        }
        .onChange(of: viewModel.selectedOrderStatus) { _ in
            Task {
                await viewModel.getItems()
            }
        }
    }
}

#Preview {
    StatisticsView()
}
