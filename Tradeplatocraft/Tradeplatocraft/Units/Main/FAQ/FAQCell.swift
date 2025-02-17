//
//  FAQCell.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import SwiftUI

struct FAQCell: View {
    let item: FAQView.FAQItem
    @State private var showText = false
    
    var body: some View {
        Button {
            showText.toggle()
        } label: {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 24) {
                    Asset.question.swiftUIImage
                    
                    Text(item.title)
                        .foregroundStyle(.black)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.forestGreen)
                        .rotationEffect(.degrees(showText ? 180 : 0))
                }
                
                if showText {
                    Text(item.text)
                        .foregroundStyle(.black)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
                }
            }
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .animation(.bouncy, value: showText)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        
        FAQCell(item: .init(
            title: "Test title",
            text: "file:///Library/Developer/CoreSimulator/Volumes/iOS_22B81/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS%2018.1.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MetalTools.framework/ principal class is nil because all fallbacks have failed"
        ))
        .padding()
    }
}
