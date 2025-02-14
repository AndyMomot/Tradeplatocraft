//
//  NextButton.swift
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var backGroundColor: Color = .blue
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.8)
                .padding(.vertical)
                .padding(.horizontal, 28)
                .background(backGroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.gray
        
        VStack {
            NextButton(title: "Další") {}
                .frame(height: 52)
                .padding(.horizontal)
            
            NextButton(title: "Další") {}
                .frame(height: 52)
                .padding(.horizontal)
        }
    }
}
