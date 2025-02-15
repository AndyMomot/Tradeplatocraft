//
//  IncomeCostCell.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct IncomeCostCell: View {
    let item: OrderCostModel
    
    @State private var image: Image?
    
    var body: some View {
        HStack(spacing: 30) {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(2)
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 1)
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            VStack(alignment: .leading, spacing: 9) {
                Text(item.name)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                
                Text(item.date.toString(format: .ddMMyyyy))
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
            }
            .foregroundStyle(.white)
            
            Spacer()
            
            Text("\(Double(item.price).string(maximumFractionDigits: 0, usesSeparator: true)) ¤")
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                .foregroundStyle(.white)
        }
        .padding(12)
        .background(.darkGreen)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white, lineWidth: 1)
        }
        .padding(1)
        .onAppear {
            Task {
                await getImage()
            }
        }
    }
}

private extension IncomeCostCell {
    func getImage() async {
        if let imageData = await FileManagerService().fetchImage(with: item.id),
           let uiImage = UIImage(data: imageData) {
            await MainActor.run {
                self.image = Image(uiImage: uiImage)
            }
        } else {
            await MainActor.run {
                self.image = Asset.logo.swiftUIImage
            }
        }
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        IncomeCostCell(item: .init(
            type: .order,
            name: "Okładki książki",
            date: .init(),
            price: 999
        ))
        .padding()
    }
}
