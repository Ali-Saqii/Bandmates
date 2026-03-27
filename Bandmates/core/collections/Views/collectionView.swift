//
//  collectionView.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import SwiftUI

struct collectionView: View {
    @EnvironmentObject var homeVm : HomeViewModel
    @State private var searchText = ""
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            VStack() {
                HStack(spacing:10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                        .padding(.leading)
                        .onTapGesture {
                            print(searchText)
                        }
                    TextField("Search Any Collection here ...", text: $searchText)
                }.frame(maxWidth:.infinity)
                    .frame(height: 60)
                    .background(Color.textfieldcolor.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal,20)
                ScrollView{
                    VStack(spacing:15) {
                        ForEach(homeVm.user.Collections) { collection in
                            CollectiomRowView(Collection: collection, editAction: {print("edit")}, DeleteActin: {print("delete")})
                        }
                    }.padding(.horizontal)
                }.scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
                    .padding(.top)
            }
        }
    }
}


#Preview {
    collectionView()
        .environmentObject(HomeViewModel())
}
