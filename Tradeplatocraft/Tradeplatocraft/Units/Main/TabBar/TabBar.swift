//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = ViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            HomeView()
                .tag(TabBarSelectionView.home.rawValue)
                .environmentObject(viewModel)
            
            AllOrdersView()
                .tag(TabBarSelectionView.orders.rawValue)
                .environmentObject(viewModel)
            
            Text("materials")
                .tag(TabBarSelectionView.materials.rawValue)
                .environmentObject(viewModel)
            
            Text("finance")
                .tag(TabBarSelectionView.finance.rawValue)
            
            Text("viewModel")
                .tag(TabBarSelectionView.settings.rawValue)
                .environmentObject(viewModel)
        }
        .overlay {
            VStack {
                Spacer()
                if viewModel.isShowTabBar {
                    TabBarCustomView(selectedItem: $viewModel.selection)
                        .frame(height: UIScreen.main.bounds.height * 0.12)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    TabBar()
}
