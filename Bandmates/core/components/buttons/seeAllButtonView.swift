//
//  seeAllButtonView.swift
//  Bandmates
//
//  Created by Mac mini on 19/03/2026.
//

import SwiftUI

struct seeAllButtonView: View {
    @Binding var isSeeAll : Bool
    var body: some View {
        Button {
            withAnimation(.easeIn){
                isSeeAll.toggle()
            }
        } label: {
            HStack(spacing:5) {
                if isSeeAll {
                    Image(systemName: "chevron.left")
                }
                Text(isSeeAll ?"See Less":"see All")
                if !isSeeAll {
                    Image(systemName: "chevron.right")
                }
            }.tint(!isSeeAll ? Color.background : Color.gray.opacity(0.8))
        }
    }
}

#Preview {
    seeAllButtonView(isSeeAll: .constant(true))
}
