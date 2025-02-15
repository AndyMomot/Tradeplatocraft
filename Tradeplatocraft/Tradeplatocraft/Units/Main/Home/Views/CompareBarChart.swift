import SwiftUI
import Charts

struct CompareBarChart: View {
    let first: Model
    let second: Model
    
    @State private var spacerValue: Double = .zero
    
    var body: some View {
        Chart {
            BarMark(x: .value("Value", Double(first.value)) ,
                    y: .value("Position", "1"))
            .foregroundStyle(first.color)
            .clipShape(RoundedRectangle(cornerRadius: 2))
            
            BarMark(x: .value("Value", spacerValue),
                    y: .value("Position", "1"))
            .foregroundStyle(.clear)
            
            BarMark(x: .value("Value", Double(second.value)) ,
                    y: .value("Position", "1"))
            .foregroundStyle(second.color)
            .clipShape(RoundedRectangle(cornerRadius: 2))
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(height: 25)
        .onAppear {
            Task {
                await calculateSpacerValue()
            }
        }
    }
}

private extension CompareBarChart {
    func calculateSpacerValue() async {
        let spacerValue = Double(first.value + second.value) * 0.01
        await MainActor.run {
            withAnimation(.bouncy) {
                self.spacerValue = spacerValue
            }
        }
    }
}

extension CompareBarChart {
    struct Model {
        let name: String
        let value: Int
        let color: Color
    }
}

#Preview {
    CompareBarChart(
        first: .init(name: "First", value: 20, color: .red),
        second: .init(name: "Second", value: 10, color: .blue)
        )
    .padding()
}
