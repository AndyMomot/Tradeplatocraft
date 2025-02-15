//
//  NavigationBarTitle.swift
//  BoFitvada
//
//  Created by Andrii Momot on 11.02.2025.
//

import SwiftUI

struct NavigationBarTitle: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(.sunsetOrange)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 36))
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationBarTitle(text: "SETTINGS")
        .background(.green)
}
