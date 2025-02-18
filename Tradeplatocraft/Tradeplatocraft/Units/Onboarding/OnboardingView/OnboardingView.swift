//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Image(item.image)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Rectangle()
                    .fill(.black)
                    .frame(maxHeight: 105)
            }
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 24) {
                    Text(item.title)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(item.text)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                }
                .padding(12)
                .background(.oceanGreen)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.sunsetOrange, lineWidth: 3)
                }
                
                VStack(spacing: 16) {
                    Button {
                        if item == .third {
                            withAnimation {
                                rootViewModel.setFlow(.main)
                            }
                        } else {
                            withAnimation {
                                currentPageIndex = item.next.rawValue
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(item.nextButtonTitle)
                                .foregroundStyle(.black)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .padding(22)
                        .background(.sunsetOrange)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black, lineWidth: 3)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button {
                        viewModel.showPrivacy.toggle()
                    } label: {
                        Text("Polityka prywatności")
                            .foregroundStyle(.darkGrey)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
                            .multilineTextAlignment(.center)
                            .padding(5)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.showPrivacy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
    }
}

#Preview {
    OnboardingView(item: .third, currentPageIndex: .constant(2))
}
