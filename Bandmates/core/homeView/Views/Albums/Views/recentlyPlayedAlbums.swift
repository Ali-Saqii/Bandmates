//
//  recentlyPlayedAlbums.swift
//  Bandmates
//
//  Created by Mac mini on 23/03/2026.
//

import SwiftUI

struct recentlyPlayedAlbums: View {
    @EnvironmentObject var hvm: HomeViewModel
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 4), count: 3)
    @State private var SearchText = ""
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            VStack(spacing:0) {
                HStack(spacing:10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                        .padding(.leading)
                    TextField("search desire albums", text: $SearchText)
                        .onTapGesture {
                            
                        }
                }.frame(maxWidth:.infinity)
                    .frame(height: 60)
                    .background(Color.textfieldcolor.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal,20)
                    .padding(.bottom)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(hvm.recentlyplayed.indices , id: \.self) { index in
                            recentlyPlayedView(image: hvm.recentlyplayed[index].image ?? "", albumName: hvm.recentlyplayed[index].name ?? ""
                            ).onTapGesture {
                                hvm.openLink(hvm.recentlyplayed[index].playLink ?? "")
                            }
                        }
                    }
                }.scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    recentlyPlayedAlbums()
        .environmentObject(HomeViewModel())
}
