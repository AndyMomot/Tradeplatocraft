import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        let privacyPolicyURL = URL(string: "https://www.google.com")
        @Published var showPrivacy = false
    }
    
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
        
        var title: String {
            switch self {
            case .first:
                return "Tworzenie unikalnych produktów"
            case .second:
                return "Koszty i zarobki"
            case .third:
                return "Organizacja i rozwój"
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Personalizacja gadżetów, malowanie ubrań i obuwia, ręczne zdobienia. Twoja kreatywność przekształcona w wyjątkowy, sprzedażowy merch."
            case .second:
                return "Obliczanie wydatków na materiały, narzędzia i czas pracy. Śledzenie dochodów ze sprzedaży, analiza rentowności zamówień."
            case .third:
                return "Personalizacja gadżetów, malowanie ubrań i obuwia, ręczne zdobienia. Twoja kreatywność przekształcona w wyjątkowy, sprzedażowy merch."
            }
        }
        
        var nextButtonTitle: String {
            switch self {
            case .first, .second:
                return "Kontynuować"
            case .third:
                return "Kontynuować"
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
