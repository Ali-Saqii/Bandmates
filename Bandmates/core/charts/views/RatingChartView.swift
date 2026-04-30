import SwiftUI

struct RatingItem {
    let label: String
    let count: Int
}

struct RatingChartView: View {
    let ratings: RatingBreakdown

    private var data: [RatingItem] {
        [
            RatingItem(label: "1 Star", count: ratings.oneStar),
            RatingItem(label: "2 Stars", count: ratings.twoStar),
            RatingItem(label: "3 Stars", count: ratings.threeStar),
            RatingItem(label: "4 Stars", count: ratings.fourStar),
            RatingItem(label: "5 Stars", count: ratings.fiveStar),
        ]
    }

    private var maxCount: Int {
        data.map(\.count).max() ?? 1
    }

    // Y axis tick values
    private var yTicks: [Int] {
        guard maxCount > 0 else { return [] }
        let step = max(1, maxCount / 4)
        return stride(from: 0, through: maxCount, by: step).map { $0 }
    }

    private let chartHeight: CGFloat = 130
    private let yAxisWidth: CGFloat  = 30
    private let xLabelHeight: CGFloat = 20

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {

            ZStack(alignment: .trailing) {
                GeometryReader { _ in
                    ForEach(yTicks, id: \.self) { tick in
                        let ratio = CGFloat(tick) / CGFloat(maxCount)
                        let y = chartHeight - ratio * chartHeight

                        Text("\(tick)")
                            .font(.system(size: 9))
                            .foregroundStyle(.secondary)
                            .frame(width: yAxisWidth - 4, alignment: .trailing)
                            .position(x: (yAxisWidth - 4) / 2, y: y)
                    }
                }
                .frame(width: yAxisWidth, height: chartHeight)
                Rectangle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 1, height: chartHeight)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .frame(width: yAxisWidth, height: chartHeight + xLabelHeight)
            .padding(.bottom, xLabelHeight)

            VStack(spacing: 0) {
                HStack(alignment: .bottom, spacing: 0) {
                    ForEach(data, id: \.label) { item in
                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(hex: "#E8437A"), Color(hex: "#f07aA0")],
                                        startPoint: .bottom,
                                        endPoint: .top
                                    )
                                )
                                .frame(
                                    width: 22,
                                    height: maxCount == 0
                                        ? 4
                                        : max(4, CGFloat(item.count) / CGFloat(maxCount) * chartHeight)
                                )
                                .animation(.easeOut(duration: 0.45), value: item.count)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: chartHeight)

                Rectangle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(height: 1)

                HStack(spacing: 0) {
                    ForEach(data, id: \.label) { item in
                        Text(item.label)
                            .font(.system(size: 11))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: xLabelHeight)
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 16)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double(int         & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    RatingChartView(ratings: RatingBreakdown(fiveStar: 4, fourStar: 160, threeStar: 45, twoStar: 55, oneStar: 89))
        .padding()
}
