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
                            if let albums = hvm.albums {
                                ForEach(albums.indices, id: \.self) { index in
                                    AlbumsRowView(
                                        albumImage: albums[index].image,
                                        albumName: albums[index].albumName,
                                        artistName: albums[index].albumArtistName,
                                        ratingCount: albums[index].averageRating,
                                        totalRatingcount: albums[index].totalRatingCount,
                                        isAlBumSaved: albums[index].isSaved
                                    ).onTapGesture {
                                        selectedAlbum = albums[index] // ✅ this triggers the navigation
                                    }
                                    .transition(.asymmetric(insertion:.move(edge: .top), removal: .move(edge: .top)))
                                }
                            }else if hvm.isLoading {
                                ProgressView()
                                    .frame(maxHeight: .infinity, alignment: .center)
                            }else {
                                NoBandmatesView(icon: "photo.artframe", height: 77, width: 77, title: "no albums".capitalized, subTitle: "refrest to get albums or check your internet", titleFont: .dmSans(18, weight: .semiBold), subTitleFont: .dmSans(16,weight: .medium), color: Color.background.opacity(0.5))
                                    .frame(maxHeight: .infinity, alignment: .center)
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
