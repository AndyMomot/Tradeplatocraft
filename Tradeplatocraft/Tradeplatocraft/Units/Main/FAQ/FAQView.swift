//
//  FAQView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import SwiftUI

struct FAQView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.darkGreen
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                NavigationBarTitle(text: "Często zadawane pytania")
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.faqItems) { item in
                            FAQCell(item: item)
                        }
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    FAQView()
}
