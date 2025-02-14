//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {}
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboard1.name
            case .second:
                return Asset.onboard2.name
            case .third:
                return Asset.onboard3.name
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return ""
            case .second:
                return ""
            case .third:
                return ""
            }
        }
        
        var nextButtonTitle: String {
            switch self {
            case .first, .second:
                return "NEXT"
            case .third:
                return "GO"
            }
        }

        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
        
        var lastIndex: Int {
            OnboardingItem.allCases.last?.rawValue ?? .zero
        }
    }
}
