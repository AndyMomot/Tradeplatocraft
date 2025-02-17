//
//  OrderCell.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import SwiftUI

struct OrderCell: View {
    let item: OrderCostModel
    var action: (ViewAction) -> Void
    
    @State private var image = Asset.logo.swiftUIImage
    @State private var profit: Double = .zero
    @State private var selectedOrderStatus = "W toku"
    private let orderStatuses = OrderCostModel.Status.allCases.map {
        $0.displayName
    }
    
    var body: some View {
        HStack(spacing: 16) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: 84, height: 84)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading, spacing: 12) {
                
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.name)
                            .foregroundStyle(.black)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        
                        Text(item.date.toString(format: .ddMMyyyy))
                            .foregroundStyle(.darkGrey)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(item.price) ¤")
                            .foregroundStyle(.black)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        
                        Text("Zysk +\(profit.string()) ¤")
                            .foregroundStyle(.darkGrey)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
                    }
                    
                    Button {
                        action(.delete(id: item.id))
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }
                
                HorisontalPicker(items: orderStatuses,
                                 itemHorizontalPadding: 12,
                                 selection: $selectedOrderStatus)
            }
        }
        .padding(12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.sunsetOrange, lineWidth: 2)
        }
        .padding(2)
        .onAppear {
            Task {
                await getImage()
                await calculateProfit()
            }
            selectedOrderStatus = item.status.displayName
        }
        .onChange(of: selectedOrderStatus) { newValue in
            action(.changeStatus(id: item.id, status: newValue))
        }
    }
}

private extension OrderCell {
    func getImage() async {
        if let imageData = await FileManagerService().fetchImage(with: item.id),
           let uiImage = UIImage(data: imageData) {
            await MainActor.run {
                image = Image(uiImage: uiImage)
            }
        }
    }
    
    func calculateProfit() async {
        let price = Double(item.price)
        let profit = Double(price) / 2
        await MainActor.run {
            self.profit = profit
        }
    }
}

extension OrderCell {
    enum ViewAction {
        case delete(id: String)
        case changeStatus(id: String, status: String)
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        
        OrderCell(item: .init(
            type: .order,
            name: "Item 1",
            date: .init(),
            price: 94324
        )) {_ in}
        .padding()
    }
}
