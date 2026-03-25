//
//  ratingStarsView.swift
//  Bandmates
//
//  Created by Mac mini on 24/03/2026.
//

import SwiftUI

struct ratingStarsView: View {
    @Binding var count: Int
    let font : Font
    let Color: Color
    var body: some View{
        ZStack{
            starView
                .overlay {
                    overlayView.mask(starView)
                }
        }
    }
    
   
    
    private var overlayView: some View {
        
        GeometryReader { geo in
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(Color)
                    .frame(width: CGFloat(count) / 5 * geo.size.width)
            }
            
        }.allowsHitTesting(false)
    }
    var starView: some View {
        HStack(spacing: 5){
            ForEach(1..<6) { Index in
                Image(systemName: "star.fill")
                    .foregroundStyle(.gray)
                    .font(font)
                    .onTapGesture {
                        count = Index
                    }
            }
        }
    }
}


#Preview {
    ratingStarsView( count: .constant(3), font: .callout, Color: .yellow)
}
