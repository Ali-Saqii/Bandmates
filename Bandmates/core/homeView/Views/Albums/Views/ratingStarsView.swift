//
//  ratingStarsView.swift
//  Bandmates
//
//  Created by Mac mini on 24/03/2026.
//

import SwiftUI

struct ratingStarsView: View {
    var count: Int
    let font : Font
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
                    .foregroundStyle(.yellow)
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
            }
        }
    }
}


#Preview {
    ratingStarsView( count: 3, font: .callout)
}
