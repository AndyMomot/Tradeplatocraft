//
//  HorisontalPicker.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import SwiftUI

struct HorisontalPicker: View {
    let items: [String]
    var itemHorizontalPadding: CGFloat = 42
    var scrollHorizontalPadding: CGFloat = .zero
    @Binding var selection: String
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(items, id: \.self) { item in
                    let isSelection = item == selection
                    Button {
                        withAnimation {
                            selection = item
                        }
                    } label: {
                        Text(item)
                            .foregroundStyle(isSelection ? .mintTeal : .forestGreen)
                            .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 12))
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .padding(.vertical, 12)
                            .padding(.horizontal, itemHorizontalPadding)
                            .background(isSelection ? .forestGreen : .mintTeal)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay {
                                if isSelection {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.sunsetOrange, lineWidth: 1)
                                        
                                }
                            }
                            .padding(isSelection ? 1 : .zero)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, scrollHorizontalPadding)
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        
        HorisontalPicker(
            items: ["Item 1", "Item 2", "Item 3", "Item 4"],
            selection: .constant("Item 1")
        )
        .padding()
    }
}
