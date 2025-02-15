//
//  AddOrderOrCostViewModel.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 15.02.2025.
//

import UIKit.UIImage
import Combine

extension AddOrderOrCostView {
    final class ViewModel: ObservableObject {
        var viewType: OrderCostModel.ItemType = .order
        @Published var title = ""
        @Published var currentState = AddOrderOrCostView.ViewState.first
        @Published var name = ""
        @Published var date = Date()
        @Published var uiImage = Asset.logo.image
        @Published var price = ""
        
        let onDismissSubj = PassthroughSubject<Void, Never>()
    }
}

extension AddOrderOrCostView.ViewModel {
    func setTitle() async {
        var title: String {
            switch viewType {
            case .order:
                return "Nowe zamówienie"
            case .cost:
                return "Nowy wydatek"
            }
        }
        
        await MainActor.run { [weak self] in
            self?.title = title
        }
    }
    
    func handleContainer(action: AddOrderOrCostView.ContainerAction) async {
        switch currentState {
        case .first:
            switch action {
            case .dismiss:
                await MainActor.run { [weak self] in
                    self?.onDismissSubj.send()
                }
            case .next:
                if !name.isEmpty {
                    await MainActor.run { [weak self] in
                        self?.currentState = .second
                    }
                }
            }
        case .second:
            switch action {
            case .dismiss:
                await MainActor.run { [weak self] in
                    self?.onDismissSubj.send()
                }
            case .next:
                if (Int(price) ?? .zero > .zero) {
                    await MainActor.run { [weak self] in
                        self?.currentState = .third
                    }
                }
            }
        case .third:
            switch action {
            case .dismiss:
                await MainActor.run { [weak self] in
                    self?.onDismissSubj.send()
                }
            case .next:
                await saveItem()
            }
        case .success:
            break
        }
    }
    
    func saveItem() async {
        guard !name.isEmpty, Int(price) ?? .zero > .zero else { return }
        
        let item = OrderCostModel(
            type: viewType,
            name: name,
            date: date,
            price: Int(price) ?? .zero
        )
        
        DefaultsService.shared.ordersAndCosts.append(item)
        
        if uiImage != Asset.logo.image, let imageData = uiImage.pngData() {
            await FileManagerService().saveImage(data: imageData, for: item.id)
        }
        
        await cleanFields()
        
        await MainActor.run { [weak self] in
            self?.currentState = .success
        }
    }
    
    func cleanFields() async {
        await MainActor.run { [weak self] in
            guard let self else { return }
            self.name = ""
            self.date = Date()
            self.uiImage = Asset.logo.image
            self.price = ""
        }
    }
}

extension AddOrderOrCostView {
    enum ContainerAction {
        case dismiss, next
    }
}

extension AddOrderOrCostView {
    enum ViewState {
        case first, second, third, success
    }
}
