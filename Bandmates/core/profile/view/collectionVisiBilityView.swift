//
//  collectionVisiBilityView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct collectionVisiBilityView: View {
    @EnvironmentObject var pvm : HomeViewModel
    @Binding var showSheet : Bool
    @State private var isVisibilityPrivate = false
    @State private var isVisibilityPublic = true
    

    var body: some View {
        VStack(spacing:30) {
            Rectangle()
                .fill(.gray)
                .frame(width: 76, height: 2)
                .padding()
            Text("Collection Visibility")
                .foregroundStyle(.black)
                .font(.dmSans(20, weight: .semiBold))
            VStack(alignment:.leading,spacing: 20) {
                HStack {
                    planSelectionCircularButton(isSelected: $isVisibilityPrivate) {
                        isVisibilityPrivate = true
                        isVisibilityPublic = false
                        
                    }
                    VStack(alignment:.leading) {
                        Text("Private")
                            .font(.dmSans(16, weight: .semiBold))
                            .foregroundStyle(.black)
                        Text("Only you can view your collection albums.")
                            .font(.dmSans(12, weight: .medium))
                            .foregroundStyle(.gray)
                    }
                }
                HStack {
                    planSelectionCircularButton(isSelected: $isVisibilityPublic) {
                        isVisibilityPrivate = false
                        isVisibilityPublic = true
                       
                    }
                    VStack(alignment:.leading) {
                        Text("Connection Only")
                            .font(.dmSans(16, weight: .semiBold))
                            .foregroundStyle(.black)
                        Text("Visible collection albums to your connected bandmates.")
                            .font(.dmSans(12, weight: .medium))
                            .foregroundStyle(.gray)
                           
                    }
                }
            }.padding()
            HStack(spacing: 20) {
                Button(role: nil) {
                        withAnimation(){
                            showSheet = false
                        }
                } label: {
                    Text("Cancel")
                        .foregroundStyle(.black.opacity(0.7))
                        .font(.dmSans(16, weight: .bold))
                        .frame(width: 160, height: 46)
                }.background(.textfieldcolor)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                Button(role: nil) {
                    
                } label: {
                    Text("Save")
                        .foregroundStyle(.white)
                        .font(.dmSans(16, weight: .bold))
                        .frame(width: 160, height: 46)
                }.background(Color.background)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
            }.padding()
            Spacer()
        }.frame(maxWidth: .infinity)
            .frame(height: 400)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(color: .textfieldcolor, radius: 25)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(edges:.bottom)
    }
}

#Preview {
    collectionVisiBilityView( showSheet: .constant(true))
        .environmentObject(ProfileViewModel())
}
