//
//  PreloaderView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI

struct PreloaderView: View {
    
    var onDidLoad: () -> Void
    
    @State private var timer: Timer?
    @State private var progress: Double = 0.0
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.darkGreen
                .ignoresSafeArea()
            
            VStack(spacing: 100) {
                Asset.logo.swiftUIImage
                
                if progress > .zero {
                    CircularProgressBar(
                        progress: progress,
                        progressColors: [.liteGreen, .liteGreen.opacity(0.25)],
                        lineWidth: 14,
                        lineCap: .round
                    )
                    .frame(maxWidth: 112)
                }
            }
        }
        .onAppear {
            startTimer()
        }
    }
}

private extension PreloaderView {
    func startTimer() {
        stopTimer()
        
        timer = .scheduledTimer(withTimeInterval: 0.01,
                                repeats: true, block: { timer in
            updateProgress(value: 0.005)
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress(value: Double) {
        DispatchQueue.main.async {
            if progress + value > 1 {
                withAnimation {
                    progress = 1
                }
                stopTimer()
                onDidLoad()
            } else {
                withAnimation {
                    progress = progress + value
                }
            }
        }
    }
}

#Preview {
    PreloaderView {}
}
