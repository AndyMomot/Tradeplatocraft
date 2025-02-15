//
//  AddOrderOrCostThirdView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct AddOrderOrCostThirdView: View {
    var image: UIImage
    var name: String
    var price: String
    var date: Date
    
    @State private var profit: Double = .zero
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 24) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 177, height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Text("Przybliżony zysk: +\(profit.string()) ¤")
                    .foregroundStyle(.pinewoodGreen)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 16) {
                Text(name)
                    .foregroundStyle(.pinewoodGreen)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("cena: \(price) ¤")
                        .foregroundStyle(.pinewoodGreen)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    
                    Text("termin: \(date.toString(format: .ddMMyyyy))")
                        .foregroundStyle(.pinewoodGreen)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                }
            }
            .padding(.trailing)
        }
        .hideKeyboardWhenTappedAround()
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.sunsetOrange, lineWidth: 3)
        }
        .padding(3)
        .onAppear {
            Task {
                await calculateProfit()
            }
        }
        .onChange(of: price) { _ in
            Task {
                await calculateProfit()
            }
        }
    }
}

private extension AddOrderOrCostThirdView {
    func calculateProfit() async {
        let price = Double(price) ?? .zero
        let profit = Double(price) / 2
        await MainActor.run {
            self.profit = profit
        }
    }
}

#Preview {
    ZStack {
        Color.green
        AddOrderOrCostThirdView(
            image: Asset.logo.image,
            name: "Obraz",
            price: "2599",
            date: .init()
        )
        .padding()
    }
}
