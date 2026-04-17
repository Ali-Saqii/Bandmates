//
//  NoBandmatesView.swift
//  Bandmates
//
//  Created by Mac mini on 01/04/2026.
//

import SwiftUI

struct NoBandmatesView: View {
    let icon: String
    let height: CGFloat
    let width: CGFloat
    let title : String
    let subTitle : String
    let titleFont: Font
    let subTitleFont: Font
    let color : Color
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: width, height: height)
                .foregroundStyle(color)
               
            Text(title)
                .foregroundStyle(.black)
                .font(titleFont)
            Text(subTitle)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
                .font(subTitleFont)
                .frame(width: 270)

        }
    }
}

#Preview {
    NoBandmatesView(icon: "figure.2",height: 70,width: 100, title: "no bandmates", subTitle: "Start requesting with other music lovers to build your band!", titleFont: .dmSans(20, weight: .semiBold),subTitleFont: .dmSans(14, weight: .medium), color: Color.background)
}
