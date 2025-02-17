//
//  SettingsButton.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import SwiftUI

struct SettingsButton: View {
    var image: String?
    var text: String?
    var action: () -> Void
    
    init(image: String, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }
    
    init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.sunsetOrange, lineWidth: 3)
                    }
                    .padding(3)
                
                if let image {
                    Image(image)
                }
                
                if let text {
                    Text(text)
                        .foregroundStyle(.oceanGreen)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            .frame(height: 120)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        
        HStack {
            SettingsButton(image: Asset.notificationsOn.name) {}
            SettingsButton(text: "Polityka prywatności") {}
                .frame(minWidth: 214)
        }
        .padding()
    }
}
