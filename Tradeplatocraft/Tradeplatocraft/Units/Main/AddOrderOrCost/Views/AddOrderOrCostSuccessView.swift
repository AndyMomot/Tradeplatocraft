//
//  AddOrderOrCostSuccessView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct AddOrderOrCostSuccessView: View {
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 100) {
            Text("Pomyślnie dodano")
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 32))
                .multilineTextAlignment(.center)
            
            Button {
                action()
            } label: {
                Text("Powrót do strony głównej")
                    .foregroundStyle(.liteGreen)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 25)
                    .padding(.horizontal, 48)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .hideKeyboardWhenTappedAround()
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        AddOrderOrCostSuccessView {}
    }
}
