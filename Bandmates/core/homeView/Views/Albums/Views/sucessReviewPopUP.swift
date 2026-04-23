//
//  sucessReviewPopUP.swift
//  Bandmates
//
//  Created by Mac mini on 22/04/2026.
//

import SwiftUI

struct sucessReviewPopUP: View {
    var body: some View {
        
        VStack() {
            Spacer()
            Image(systemName: "checkmark")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.semibold)
                .frame(width: 88, height: 88)
                .background(
                    Circle()
                        .fill(Color.background)
                )
                Spacer()
            Text("Review Submitted!")
                .font(.dmSans(20, weight: .bold))
                .foregroundStyle(Color.background)
                .padding(.bottom)
            
        }.frame(maxWidth: .infinity)
            .frame(height: 261)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color:.textfieldcolor,radius: 15)
            .padding(.horizontal,30)
    }
}

#Preview {
    sucessReviewPopUP()
}
