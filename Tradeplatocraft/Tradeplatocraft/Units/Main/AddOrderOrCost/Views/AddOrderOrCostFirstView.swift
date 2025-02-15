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
        Color.pinewoodGreen
            .frame(height: 100)
    }
}

#Preview {
    AddOrderOrCostFirstView(
        name: .constant("Name"),
        date: .constant(.init())
    )
}
