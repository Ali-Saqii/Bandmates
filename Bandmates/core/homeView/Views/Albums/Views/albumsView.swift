//
//  albumsView.swift
//  Bandmates
//
//  Created by Mac mini on 23/03/2026.
//

import SwiftUI

struct albumsView: View {
    @EnvironmentObject var hvm: HomeViewModel
    @State private var SearchText = ""
    @State private var selectedAlbum: albumModel? = nil

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                VStack {
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
                    ScrollView {
                        VStack {
                            ForEach(hvm.albums.indices, id: \.self) { index in
                                AlbumsRowView(
                                    albumImage: hvm.albums[index].image,
                                    albumName: hvm.albums[index].albumName,
                                    artistName: hvm.albums[index].albumArtistName,
                                    ratingCount: hvm.albums[index].averageRating,
                                    totalRatingcount: hvm.albums[index].totalRatingCount,
                                    isAlBumSaved: hvm.albums[index].isSaved
                                ).onTapGesture {
                                    selectedAlbum = hvm.albums[index] // ✅ this triggers the navigation
                                }
                                .transition(.asymmetric(insertion:.move(edge: .top), removal: .move(edge: .top)))
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
            }
            
        }.navigationTitle("Albums")
            .navigationDestination(item: $selectedAlbum) { album in
                AlbumDetailsView(album: album)
                    .environmentObject(hvm)
            }
    }
}
#Preview {
    albumsView()
        .environmentObject(HomeViewModel())
}
