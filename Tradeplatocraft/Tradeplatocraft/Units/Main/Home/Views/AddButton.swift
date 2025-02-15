//
//  AddButton.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct AddButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 26) {
                Text(title)
                    .foregroundStyle(.black)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                    .minimumScaleFactor(0.5)
                
                HStack {
                    Spacer()
                    Asset.plus.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                }
            }
            .padding(9)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.sunsetOrange, lineWidth: 3)
            }
            .frame(width: 115, height: 120)
            .padding(3)
        }
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        AddButton(title: "Nowe zamówienie") {
            
        }
    }
}
