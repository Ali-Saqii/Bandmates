//
//  textFieldButtonsView.swift
//  Bandmates
//
//  Created by Mac mini on 13/03/2026.
//

import SwiftUI

struct textFieldButtonsView: View {
    @Binding var isVisible : Bool
    
    var body: some View {
        Button {
            isVisible.toggle()
        } label: {
            Image(systemName: isVisible ? "eye.fill" : "eye.slash.fill")
                .font(.callout)
                .foregroundStyle(.gray)
                .frame(alignment: .center)
        }

    }
}

#Preview {
    textFieldButtonsView(isVisible: .constant(false))
}
