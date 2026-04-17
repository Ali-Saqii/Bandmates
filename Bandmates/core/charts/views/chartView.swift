//
//  chartView.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

//import SwiftUI
//
//struct chartView: View {
//    var body: some View {
//        ZStack {
//            Color.white
//                .ignoresSafeArea(.all)
//            VStack {
//                Text("chartView")
//            }
//        }
//        
//    }
//}
//
//#Preview {
//    chartView()
//}
import SwiftUI

// MARK: - Star Distribution Chart

/// Drop this view anywhere you display an album.
/// Pass the album's `ratingDistribution` array (index 0 = 1★, index 4 = 5★)
/// and an optional `growthPercent` for the header badge.

struct StarDistributionChart: View {

    // e.g. [10, 18, 55, 95, 42]  →  1★…5★ review counts
    let distribution: [Int]
    let growthPercent: Int          // shown as "All time +X%"
    let accentColor: Color          // hot-pink by default

    init(
        distribution: [Int],
        growthPercent: Int = 0,
        accentColor: Color = Color(hex: "#FF2D87")
    ) {
        self.distribution = distribution
        self.growthPercent = growthPercent
        self.accentColor   = accentColor
    }

    // ── helpers ─────────────────────────────────────────────────────────────

    private var maxValue: Int { distribution.max() ?? 1 }

    /// Nice rounded ceiling for the Y-axis (next multiple of 20)
    private var yMax: Int {
        let raw = maxValue
        let step = 20
        return ((raw + step - 1) / step) * step
    }

    private var ySteps: [Int] {
        stride(from: 0, through: yMax, by: 20).map { $0 }
    }

    // ── body ─────────────────────────────────────────────────────────────────

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // "All time +20%" badge
            if growthPercent > 0 {
                HStack(spacing: 4) {
                    Text("All time")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.primary)
                    Text("+\(growthPercent)%")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(Color(hex: "#22C55E"))
                }
            }

            // Chart
            GeometryReader { geo in
                let chartWidth  = geo.size.width
                let chartHeight = geo.size.height
                let barCount    = distribution.count          // 5
                let yAxisWidth: CGFloat = 32
                let plotWidth   = chartWidth - yAxisWidth
                let barSlot     = plotWidth / CGFloat(barCount)
                let barWidth    = barSlot * 0.45
                let barSpacing  = (barSlot - barWidth) / 2

                ZStack(alignment: .bottomLeading) {

                    // ── Grid lines + Y labels ────────────────────────────
                    VStack(spacing: 0) {
                        ForEach(ySteps.reversed(), id: \.self) { val in
                            HStack(alignment: .center, spacing: 6) {
                                Text("\(val)")
                                    .font(.system(size: 9, weight: .medium))
                                    .foregroundStyle(Color.secondary.opacity(0.7))
                                    .frame(width: yAxisWidth - 6, alignment: .trailing)

                                Rectangle()
                                    .fill(Color(.separator).opacity(0.35))
                                    .frame(height: 0.5)
                            }
                            if val != ySteps.first { Spacer() }
                        }
                    }
                    .frame(height: chartHeight - 20) // leave room for X labels

                    // ── Bars + X labels ──────────────────────────────────
                    HStack(alignment: .bottom, spacing: 0) {
                        // push bars past the Y-axis column
                        Spacer().frame(width: yAxisWidth)

                        ForEach(0..<barCount, id: \.self) { i in
                            let count       = i < distribution.count ? distribution[i] : 0
                            let ratio       = CGFloat(count) / CGFloat(yMax)
                            let maxPlotH    = chartHeight - 20   // subtract X-label space
                            let barH        = max(ratio * maxPlotH, 2)
                            let isHighest   = count == maxValue

                            VStack(spacing: 4) {
                                Spacer()

                                // bar
                                ZStack(alignment: .bottom) {
                                    // faded background column (like the screenshot's ghost bar)
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(accentColor.opacity(0.18))
                                        .frame(width: barWidth, height: maxPlotH)

                                    // solid fill bar
                                    AnimatedBar(
                                        height: barH,
                                        width: barWidth,
                                        color: accentColor,
                                        isHighest: isHighest,
                                        delay: Double(i) * 0.07
                                    )
                                }
                                .frame(width: barWidth, height: maxPlotH)

                                // X label
                                Text("\(i + 1) Star")
                                    .font(.system(size: 9, weight: .medium))
                                    .foregroundStyle(Color.secondary.opacity(0.8))
                                    .frame(height: 16)
                            }
                            .frame(width: barSlot)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Animated Bar

private struct AnimatedBar: View {
    let height: CGFloat
    let width: CGFloat
    let color: Color
    let isHighest: Bool
    let delay: Double

    @State private var animH: CGFloat = 0

    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(
                LinearGradient(
                    colors: isHighest
                        ? [color.opacity(0.55), color]
                        : [color.opacity(0.35), color.opacity(0.65)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: width, height: animH)
            .onAppear {
                withAnimation(
                    .spring(response: 0.55, dampingFraction: 0.72)
                    .delay(delay)
                ) { animH = height }
            }
            .onChange(of: height) { _, newH in
                withAnimation(.spring(response: 0.45, dampingFraction: 0.75)) {
                    animH = newH
                }
            }
    }
}

// MARK: - Color Helper (safe to skip if already defined elsewhere)

extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var v: UInt64 = 0
        Scanner(string: h).scanHexInt64(&v)
        self.init(
            red:   Double((v >> 16) & 0xFF) / 255,
            green: Double((v >> 8)  & 0xFF) / 255,
            blue:  Double( v        & 0xFF) / 255
        )
    }
}

// MARK: - Preview

#Preview("Expanded Album Row Chart") {
    VStack(alignment: .leading, spacing: 16) {

        // Simulates an expanded album card (Random Memories / +20%)
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("4.5")
                            .font(.system(size: 28, weight: .bold))
                    }
                }
                Spacer()
            }

            StarDistributionChart(
                distribution: [10, 18, 55, 95, 42],
                growthPercent: 20
            )
            .frame(height: 160)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)

        // Second album (Electric Sunset / +18%)
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("3.8")
                        .font(.system(size: 28, weight: .bold))
                }
                Spacer()
            }

            StarDistributionChart(
                distribution: [15, 35, 70, 55, 60],
                growthPercent: 18
            )
            .frame(height: 160)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
