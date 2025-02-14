//
//  CircularProgressBar.swift
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct CircularProgressBar: View {
    var progress: Double
    var bgColor: Color = .clear
    var trackColor: Color = .clear
    var progressColors: [Color] = [.blue]
    
    var lineWidth: CGFloat = 18
    var lineCap: CGLineCap = .butt
    
    var imageName: String?
    
    var text: String?
    var textColor: Color = .blue
    var textFont = Fonts.SFProDisplay.bold.swiftUIFont(size: 35)
    
    var description: String?
    var descriptionColor: Color = .blue
    var descriptionFont = Fonts.SFProDisplay.regular.swiftUIFont(size: 25)
    
    var body: some View {
        ZStack {
            Circle()
                .fill(bgColor)
            
            Circle()
                .stroke( // 1
                    trackColor,
                    lineWidth: lineWidth
                )
                .padding(lineWidth / 2)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke( // 1
                    LinearGradient(
                        colors: progressColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: .init(
                        lineWidth: lineWidth,
                        lineCap: lineCap
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
                .padding(lineWidth / 2)
            
            VStack(alignment: .center, spacing: 10) {
                if let imageName {
                    Image(imageName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(
                            LinearGradient(
                                colors: progressColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(maxWidth: 50)
                }
                
                if let text {
                    Text(text)
                        .foregroundStyle(textColor)
                        .font(textFont)
                        .lineLimit(2)
                        .minimumScaleFactor(0.6)
                        .multilineTextAlignment(.center)
                }
                
                if let description {
                    Text(description)
                        .foregroundStyle(descriptionColor)
                        .font(descriptionFont)
                        .lineLimit(2)
                        .minimumScaleFactor(0.6)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding(lineWidth / 2)
    }
}

#Preview {
    ZStack {
        Color.gray
        
        CircularProgressBar(
            progress: 1,
            progressColors: [.red],
            imageName: Asset.logo.name,
            text: "75%",
            description: "7/10 tasks"
        )
    }
}
