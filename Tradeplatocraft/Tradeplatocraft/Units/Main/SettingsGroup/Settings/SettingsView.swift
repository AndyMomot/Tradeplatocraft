//
//  SettingsView.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.darkGreen
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                    Asset.logo.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .padding(4)
                        .background(.black)
                        .frame(width: 62)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                
                VStack(spacing: 24) {
                    NavigationBarTitle(text: "Ustawienia")
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                SettingsButton(image: viewModel.notificationImageName) {
                                    Task {
                                        await viewModel.onToggleNotifications()
                                    }
                                }
                                
                                SettingsButton(text: "Często zadawane pytania") {
                                    viewModel.showFAQ.toggle()
                                }
                                .frame(minWidth: bounds.width * 0.55)
                            }
                            
                            HStack(spacing: 16) {
                                SettingsButton(image: Asset.updateApp.name) {
                                    if let url = viewModel.appStoreURL {
                                        UIApplication.shared.open(url)
                                    }
                                }
                                
                                SettingsButton(text: "Polityka prywatności") {
                                    viewModel.showPrivacyPolicy.toggle()
                                }
                                .frame(minWidth: bounds.width * 0.55)
                            }
                        }
                        .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                Task {
                    await viewModel.updateNotificationImageName()
                }
            }
            .sheet(isPresented: $viewModel.showPrivacyPolicy) {
                SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
            }
            .navigationDestination(isPresented: $viewModel.showFAQ) {
                FAQView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
