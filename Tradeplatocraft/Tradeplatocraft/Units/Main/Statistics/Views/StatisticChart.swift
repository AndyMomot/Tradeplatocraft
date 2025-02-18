//
//  StatisticChart.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 18.02.2025.
//

import SwiftUI
import Charts

struct StatisticChart: View {
    let items: [OrderCostModel]
    @State private var totalAmount: Int = .zero
    @State private var averageAmount: Int = .zero
    @State private var colors: [Color] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Przeciętny")
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                    
                    Text("\(averageAmount)")
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 30))
                }
                .multilineTextAlignment(.leading)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 10) {
                    Text("Całkowity")
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                    
                    Text("\(totalAmount)")
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 30))
                }
                .multilineTextAlignment(.trailing)
            }
            .foregroundStyle(.black)
            
            if items.isEmpty {
                Text("Nie znaleziono elementów")
                    .foregroundStyle(.black)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                    .frame(maxWidth: .infinity)
                
            } else {
                Chart {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        var color: Color {
                            if colors.indices.contains(index) {
                                return colors[index]
                            } else {
                                return .gray
                            }
                        }
                        
                        BarMark(
                            x: .value("1", item.name),
                            y: .value("2", item.price)
                        )
                        .foregroundStyle(color)
                    }
                }
                .chartXAxis(.hidden)
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        var color: Color {
                            if colors.indices.contains(index) {
                                return colors[index]
                            } else {
                                return .gray
                            }
                        }
                        
                        HStack(spacing: 12) {
                            Circle()
                                .fill(color)
                                .frame(width: 16)
                            Text(item.name)
                            
                            Spacer()
                            
                            Text(getPercentFor(item: item))
                        }
                        .foregroundStyle(.black.opacity(0.8))
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                    }
                }
            }
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.darkGrey, lineWidth: 1)
        }
        .padding(1)
        .onAppear {
            Task {
                await calculateTotalAmount()
                await generateColors(count: items.count)
            }
        }
        .onChange(of: items) { _ in
            Task {
                await calculateTotalAmount()
                await generateColors(count: items.count)
            }
        }
    }
}

private extension StatisticChart {
    func calculateTotalAmount() async {
        guard !items.isEmpty else {
            await MainActor.run {
                self.totalAmount = .zero
                self.averageAmount = .zero
            }
            return
        }
        
        let totalAmount = items.map { $0.price }.reduce(0) { $0 + $1 }
        let averageAmount = totalAmount / items.count
        
        await MainActor.run {
            self.totalAmount = totalAmount
            self.averageAmount = averageAmount
        }
    }
    
    func getPercentFor(item: OrderCostModel) -> String {
        let totalAmount = items.map { $0.price }.reduce(0) { $0 + $1 }
        let percent = (Double(item.price) / Double(totalAmount)) * 100
        return "\(percent.string(maximumFractionDigits: 0))%"
    }
    
    func generateColors(count: Int) async {
        let baseColors: [Color] = [
            .red, .blue, .green, .yellow, .orange,
            .purple, .pink, .teal, .mint, .brown,
            .indigo, .cyan, .gray
        ].shuffled()
        
        let colors = (0..<count).map { baseColors[$0 % baseColors.count] }
        
        await MainActor.run {
            self.colors = colors
        }
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        
        ScrollView {
            StatisticChart(
                items: [
                    .init(type: .order, name: "Item 1", date: .init(), price: 2099),
//                    .init(type: .order, name: "Item 2", date: .init(), price: 2399),
//                    .init(type: .order, name: "Item 3", date: .init(), price: 2299),
//                    .init(type: .order, name: "Item 4", date: .init(), price: 4399),
//                    .init(type: .order, name: "Item 5", date: .init(), price: 1399),
                ]
            )
        }
        .padding()
    }
}
