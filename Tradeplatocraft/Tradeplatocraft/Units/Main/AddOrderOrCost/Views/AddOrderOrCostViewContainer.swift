//
//  AddOrderOrCostViewContainer.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct AddOrderOrCostViewContainer<Content: View>: View {
    let title: String
    let content: Content
    let action: (AddOrderOrCostView.ContainerAction) -> Void
    
    init(title: String,
         @ViewBuilder content: () -> Content,
         action: @escaping (AddOrderOrCostView.ContainerAction) -> Void) {
        self.title = title
        self.content = content()
        self.action = action
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 54) {
                HStack {
                    Text(title)
                        .foregroundStyle(.sunsetOrange)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 36))
                    
                    Spacer()
                    
                    Button {
                        action(.dismiss)
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.white)
                    }
                }
                
                content
                
                HStack {
                    Spacer()
                    
                    Button {
                        action(.next)
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
            }
            .padding()
            .background(Color.pinewoodGreen)
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        AddOrderOrCostViewContainer(title: "Nowe zamówienie") {
            Text("Some Content")
        } action: { action in
            
        }
    }
}
