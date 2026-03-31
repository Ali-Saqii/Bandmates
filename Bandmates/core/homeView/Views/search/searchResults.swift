//
//  searchResults.swift
//  Bandmates
//
//  Created by Mac mini on 31/03/2026.
//

import SwiftUI

struct searchResults: View {
    @EnvironmentObject var hvm: HomeViewModel
    @FocusState private var isSearchFocused: Bool
    @State private var albums = false
    @State private var bandmates = false
    var isSearchEmpty: Bool {
        hvm.searchText.isEmpty
    }
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
       
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                            .padding()
                        TextField("Search album,artist or bandmate ...", text: $hvm.searchText)
                            .keyboardType(.default)
                            .focused($isSearchFocused)
                    }
                    .frame(height: 55)
                    .background(.textfieldcolor)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal)
                    if hvm.searchResults != ([],[]) {
                        HStack {
                            VStack(spacing:5) {
                                Text("All")
                                    .foregroundStyle(!albums && !bandmates ? Color.background : .gray)
                                    .font(.dmSans(16, weight: .semiBold))
                                Rectangle()
                                    .fill(!albums && !bandmates ? Color.background : .clear)
                                    .frame(width: 40, height: 2)
                            }
                            .onTapGesture {
                                withAnimation() {
                                    albums = false
                                    bandmates = false
                                }
                            }
                            VStack(spacing:5) {
                                Text("Albums")
                                    .foregroundStyle(albums ? Color.background : .gray)
                                    .font(.dmSans(16, weight: .semiBold))
                                Rectangle()
                                    .fill(albums ? Color.background : .clear)
                                    .frame(width: 60, height: 2)
                            }.onTapGesture {
                                withAnimation() {
                                    albums = true
                                    bandmates = false
                                }
                            }
                            VStack(spacing:5) {
                                Text("Bandmates")
                                    .foregroundStyle(bandmates ? Color.background: .gray)
                                    .font(.dmSans(16, weight: .semiBold))
                                Rectangle()
                                    .fill(bandmates ? Color.background : .clear)
                                    .frame(width: 70, height: 2)
                            }  .onTapGesture {
                                withAnimation() {
                                    bandmates = true
                                    albums = false
                                }
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        if albums {
                            searchedAlbums()
                                .environmentObject(hvm)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        } else if bandmates {
                            searchBandmates()
                                .environmentObject(hvm)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        } else {
                            Group {
                                searchedAlbums()
                                    .environmentObject(hvm)
                                searchBandmates()
                                    .environmentObject(hvm)
                            }.transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                        
                    } else {VStack{}.frame(maxHeight: .infinity)}
                    
                }
            
        }.navigationTitle(isSearchEmpty ? "Search" : "Search Results")
            .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    searchResults()
        .environmentObject(HomeViewModel())
}


