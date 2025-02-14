import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    private let items: [TabBar.Item] = [
        .init(imageName: Asset.tab1.name),
        .init(imageName: Asset.tab2.name),
        .init(imageName: Asset.tab3.name),
        .init(imageName: Asset.tab4.name),
        .init(imageName: Asset.tab5.name)
    ]
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.forestGreen)
                .cornerRadius(12, corners: [.topLeft, .topRight])
            
            HStack(spacing: 0) {
                Spacer()
                ForEach(0..<items.count, id: \.self) { index in
                    let item = items[index]
                    let isSelected = selectedItem == index
                    
                    ZStack {
                        if isSelected {
                            Circle()
                                .fill(.white)
                                .frame(width: 62)
                                .transition(AnyTransition.scale.animation(.easeInOut))
                        }
                        
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(6)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    selectedItem = index
                                }
                            }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    VStack {
        Spacer()
        TabBarCustomView(selectedItem: .constant(0))
            .frame(height: 94)
    }
}
