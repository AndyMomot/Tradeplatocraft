//
//  FAQViewModel.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import Foundation

extension FAQView {
    final class ViewModel: ObservableObject {
        let faqItems: [FAQItem] = [
            .init(
                title: "Test title",
                text: "file:///Library/Developer/CoreSimulator/Volumes/iOS_22B81/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS%2018.1.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MetalTools.framework/ principal class is nil because all fallbacks have failed"
            )
        ]
    }
}

extension FAQView {
    struct FAQItem: Identifiable {
        private(set) var id = UUID().uuidString
        let title: String
        let text: String
    }
}
