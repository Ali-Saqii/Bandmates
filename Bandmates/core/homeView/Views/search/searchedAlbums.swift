//
//  searchedAlbums.swift
//  Bandmates
//
//  Created by Mac mini on 31/03/2026.
//

import SwiftUI

struct searchedAlbums: View {
    @EnvironmentObject var hvm : HomeViewModel
    @State private var selectedAlbum : albumModel? = nil
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Albums")
                        .foregroundStyle(.black)
                        .font(.dmSans(20, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if !hvm.searchResults.albums.isEmpty {
                        ForEach(hvm.searchResults.albums) { albums in
                            AlbumsRowView(albumImage: albums.image, albumName: albums.albumName, artistName: albums.albumArtistName, ratingCount: albums.averageRating, totalRatingcount: albums.totalRatingCount, isAlBumSaved: albums.isSaved)
                                .onTapGesture {
                                    selectedAlbum = albums
                                }
                        }
                    } else {}
                }.padding(.horizontal)
            }.scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)
        }.navigationDestination(item: $selectedAlbum) { album in
            AlbumDetailsView(album: album)
                .environmentObject(hvm)
        }
    }
}

#Preview {
    searchedAlbums()
        .environmentObject(HomeViewModel())
}
