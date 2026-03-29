//
//  reUsableBottomSheet.swift
//  Bandmates
//
//  Created by Mac mini on 28/03/2026.
//

import SwiftUI

struct reUsableBottomSheet: View {
    let sheetTitle: String
    let sheetWarning: String
    let buttonTitle1: String
    let buttonTitle2: String
    let button1Action: () -> Void
    let button2Action: () -> Void
    let button1Role: ButtonRole?
    let button2Role: ButtonRole?
    var body: some View {
            VStack(spacing:25) {
                Rectangle()
                    .fill(.black.opacity(0.5))
                    .frame(width: 80, height: 2)
                    .padding()
                Text(sheetTitle)
                    .foregroundStyle(.black)
                    .font(.dmSans(22, weight: .semiBold))
                Text(sheetWarning)
                    .foregroundStyle(.black)
                    .font(.dmSans(18, weight: .medium))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding()
                HStack(spacing: 20) {
                    Button(role: button1Role) {
                        button1Action()
                    } label: {
                        Text(buttonTitle1)
                            .foregroundStyle(.black.opacity(0.7))
                            .font(.dmSans(16, weight: .bold))
                            .frame(width: 160, height: 46)
                    }.background(.textfieldcolor)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    Button(role: button2Role) {
                        button2Action()
                    } label: {
                        Text(buttonTitle2)
                            .foregroundStyle(.white)
                            .font(.dmSans(16, weight: .bold))
                            .frame(width: 160, height: 46)
                    }.background(Color.background)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                }.padding(.horizontal)
                Spacer()
            }.frame(maxWidth: .infinity)
                .frame(height: 300)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .shadow(color: .textfieldcolor, radius: 25)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea(edges:.bottom)
        }
}

#Preview {
    reUsableBottomSheet(sheetTitle: "Delete Collection?", sheetWarning: "Are you sure you want to delete this collection?", buttonTitle1: "cancel", buttonTitle2: "yes.delete".capitalized,button1Action: {},button2Action: {},button1Role: .cancel,button2Role: nil)
}
