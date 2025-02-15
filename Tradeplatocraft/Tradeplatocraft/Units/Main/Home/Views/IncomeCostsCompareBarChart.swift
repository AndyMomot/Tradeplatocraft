//
//  IncomeCostsCompareBarChart.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct IncomeCostsCompareBarChart: View {
    let income: Int
    let costs: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Porównanie dochodów i wydatków")
                .foregroundStyle(.sunsetOrange)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
            
            HStack(spacing: 20) {
                createTitle(name: "Dochód", value: income, alignment: .leading)
                
                
                CompareBarChart(
                    first: .init(name: "Dochód",
                                 value: income,
                                 color: .oceanGreen
                                ),
                    second: .init(
                        name: "Koszty",
                        value: costs,
                        color: .sunsetOrange
                    )
                )
                
                createTitle(name: "Koszty", value: costs, alignment: .trailing)
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.sunsetOrange, lineWidth: 1)
            }
            .padding(1)
        }
    }
}

extension IncomeCostsCompareBarChart {
    func createTitle(name: String, value: Int, alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: 8) {
            Text(name)
                .foregroundStyle(.black)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
            
            Text("\(value)")
                .foregroundStyle(.black)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 30))
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
    }
}

#Preview {
    ZStack {
        Color.darkGreen
        IncomeCostsCompareBarChart(income: 1000, costs: 300)
            .padding()
    }
}
