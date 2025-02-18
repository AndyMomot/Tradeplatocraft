//
//  SettingsViewModel.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import Foundation

extension SettingsView {
    final class ViewModel: ObservableObject {
        @Published var notificationImageName = Asset.notificationsOff.name
        @Published var showFAQ = false
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
        let appStoreURL = URL(string: "https://apps.apple.com/app/id6740994248")
    }
}

extension SettingsView.ViewModel {
    func onToggleNotifications() async {
        do {
            let granted = try await NotificationManager.shared.requestPermission()
            if !granted {
                NotificationManager.shared.openNotificationSettings()
            } else {
                await updateNotificationImageName()
            }
        } catch {
            NotificationManager.shared.openNotificationSettings()
        }
    }
    
    func updateNotificationImageName() async {
        let isGranted = await checkNotificationPermission()
        let imageName = isGranted ? Asset.notificationsOn.name : Asset.notificationsOff.name
        await MainActor.run { [weak self] in
            guard let self else { return }
            self.notificationImageName = imageName
        }
    }
    
    func checkNotificationPermission() async -> Bool {
        let permission = await NotificationManager.shared.checkPermission()
        var isGranted: Bool {
            switch permission {
            case .authorized, .provisional:
                return true
            default:
                return false
            }
        }
        
        return isGranted
    }
}
