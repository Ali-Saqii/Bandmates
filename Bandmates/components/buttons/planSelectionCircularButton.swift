//
//  planSelectionCircularButton.swift
//  Bandmates
//
//  Created by Mac mini on 15/03/2026.
//

import SwiftUI

struct planSelectionCircularButton: View {
    @Binding var isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Circle()
                .stroke(isSelected ? Color.background : .gray, lineWidth: 2.5)
                .frame(width: 20, height: 20)
                .overlay {
                    Circle()
                        .fill(isSelected ? Color.background : .white)
                        .frame(width: 10, height: 10)
                        
                }
        }.padding(.all,7)
    }
}

#Preview {
    planSelectionCircularButton(isSelected: .constant(true), action: {})
}
