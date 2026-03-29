//
//  reusabletextEditor.swift
//  Bandmates
//
//  Created by Mac mini on 26/03/2026.
//

import SwiftUI

struct reusabletextEditor: View {
    @Binding var text : String
    let  PlaceHolder : String
    let height: CGFloat
    let color : Color
    @State private var placeHolder = ""
    var body: some View {
        TextEditor(text: $text)
            .padding(.horizontal)
            .frame(height: height)
            .scrollContentBackground(.hidden)
            .padding(.horizontal)
               .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                    .padding(.horizontal)
               )
            .overlay(content: {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .stroke(Color.inputBorder, lineWidth: 1)
                    .padding(.horizontal)
                    .overlay(alignment:.topLeading) {
                        Text(placeHolder)
                            .font(.callout)
                            .foregroundStyle(.black.opacity(0.7))
                            .padding(.horizontal)
                            .padding()
                    }.onTapGesture {
                        placeHolder = ""
                    }
            })
    }
    
    private func getPlaceHolder() {
        self.placeHolder = PlaceHolder
    }
}

#Preview {
    reusabletextEditor(text: .constant(""), PlaceHolder: "dfjhfdsggb jkfh", height: 150, color: .textfieldcolor.opacity(0.3))
}
