//
//  AddOrderOrCostSecondView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import SwiftUI

struct AddOrderOrCostSecondView: View {
    @Binding var image: UIImage
    @Binding var price: String
    
    @State private var showImagePicker = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 42) {
            VStack(alignment: .leading, spacing: 30) {
                Text("Prześlij zdjęcie")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                
                HStack(spacing: 6) {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            Text("Prześlij zdjęcie z urządzenia")
                                .foregroundStyle(.black)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                            
                            Spacer()
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button {
                        withAnimation {
                            image = Asset.logo.image
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 30) {
                Text("Cena")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                
                TextField("¤", text: $price)
                    .foregroundStyle(.black)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    .padding(.vertical)
                    .padding(.horizontal, 12)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .keyboardType(.numberPad)
            }
        }
        .hideKeyboardWhenTappedAround()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $image)
        }
    }
}

#Preview {
    ZStack {
        Color.green
        AddOrderOrCostSecondView(
            image: .constant(Asset.logo.image),
            price: .constant("")
        )
        .padding()
    }
}
