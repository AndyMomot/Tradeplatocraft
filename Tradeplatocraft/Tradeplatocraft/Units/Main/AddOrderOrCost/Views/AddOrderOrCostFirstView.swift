//
//  AddOrderOrCostFirstView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct AddOrderOrCostFirstView: View {
    @Binding var name: String
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 42) {
            VStack(alignment: .leading, spacing: 30) {
                Text("Nazwa")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                
                TextField("", text: $name)
                    .foregroundStyle(.black)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    .padding(.vertical)
                    .padding(.horizontal, 12)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 30) {
                Text("Termin")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                
                HStack {
                    DatePicker(
                        "",
                        selection: $date,
                        displayedComponents: .date)
                    .labelsHidden()
                    Spacer()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .hideKeyboardWhenTappedAround()
    }
}

#Preview {
    ZStack {
        Color.green
        AddOrderOrCostFirstView(
            name: .constant("Name"),
            date: .constant(.init())
        )
        .padding()
    }
}
