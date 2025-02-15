//
//  BalanceView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct BalanceView: View {
    let value: Int
    
    var body: some View {
        Text("\(Double(value).string(maximumFractionDigits: 0, usesSeparator: true)) ¤")
            .foregroundStyle(.sunsetOrange)
            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.sunsetOrange, lineWidth: 1)
            }
            .padding(1)
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        BalanceView(value: 80_000)
            .padding()
    }
}
