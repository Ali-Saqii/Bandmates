//
//  homwView.swift
//  Bandmates
//
//  Created by Mac mini on 12/03/2026.
//

import SwiftUI

struct homwView: View {
    @StateObject var homeVm: HomeViewModel = HomeViewModel()
    @State private var recentlyPlayedSeeAll = false
    @State private var recommendedAlbumsSeeAll = false
    @State private var seeAllBandmates = false

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            ScrollView {
                LazyVStack(spacing:20,pinnedViews:[.sectionHeaders]) {
                    greetinTextView
                    searchFieldView
                    if !homeVm.recentlyplayed.isEmpty {
                        Section {
                            recentlyPlayedAlbumsView
                            
                        } header: {
                            recentlyPlayedButtonView
                        }
                    }
                    Section {
                        recommendedAlbumsView
                    } header: {
                        recommendedAlbumsButtonView
                    }
                    Section {
                        bandmatesView
                    } header: {
                        bandmatesButtonView
                    }
                }
            }.scrollIndicators(.hidden)
        }
    }
}

extension homwView {
    private var greetinTextView: some View {
        HStack {
            Text("hey Xyz,".capitalized)
            Text(homeVm.greeting)
                .font(.headline)
                .bold()
        }.frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 20)
            .padding(.horizontal)
    }
    private var searchFieldView: some View {
        HStack(spacing:10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
                .padding(.leading)
            TextField("search albums,artists and bandmates", text: $homeVm.searchText)
                .onTapGesture {
                    
                }
        }.frame(maxWidth:.infinity)
            .frame(height: 60)
            .background(Color.textfieldcolor.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal,20)
    }
    private var recentlyPlayedButtonView: some View {
        HStack {
            seeAllView(text: "recently Played")
            Spacer()
            seeAllButtonView(isSeeAll: $recentlyPlayedSeeAll)
        }.padding(.horizontal)
    }
    private var recentlyPlayedAlbumsView: some View {
        ScrollView(.horizontal) {
            HStack(spacing:20) {
                ForEach(homeVm.recentlyplayed) { album in
                    recentlyPlayedView(image: album.image, albumName: album.albumName)
                }
            }.padding(.leading)
        }.scrollDisabled(!recentlyPlayedSeeAll)
            .scrollIndicators(.hidden)
    }
    private var recommendedAlbumsButtonView: some View {
        HStack {
            seeAllView(text: "Recommended Albums")
            Spacer()
            seeAllButtonView(isSeeAll: $recommendedAlbumsSeeAll)
        }.padding(.horizontal)
    }
    private var recommendedAlbumsView: some View {
        VStack {
            ForEach(recommendedAlbumsSeeAll ? Array(homeVm.albums.indices) : Array(homeVm.albums.prefix(3).indices), id: \.self) { index in
                AlbumsRowView(
                           albumImage: homeVm.albums[index].image,
                           albumName: homeVm.albums[index].albumName,
                           artistName: homeVm.albums[index].albumArtistName,
                           ratingCount: homeVm.albums[index].averageRating,
                           totalRatingcount: homeVm.albums[index].totalRatingCount,
                           isAlBumSaved: $homeVm.albums[index].isSaved
                ).transition(.asymmetric(insertion:.move(edge: .top), removal: .move(edge: .top)))
            }
        }
    }
    private var bandmatesButtonView: some View {
        HStack {
            seeAllView(text: "Bandmates")
            Spacer()
            seeAllButtonView(isSeeAll: $seeAllBandmates)
        }.padding(.horizontal)
    }
    private var bandmatesView: some View {
        VStack {
            ForEach(seeAllBandmates ? Array(homeVm.bandmates.indices) : Array(homeVm.bandmates.prefix(3).indices), id: \.self) { index in
                BandmatesRowView(
                    personImage: homeVm.bandmates[index].image,
                    PersonName: homeVm.bandmates[index].fullName,
                    personUserName: homeVm.bandmates[index].userName,
                    isRequested: $homeVm.bandmates[index].isRequested
                ).transition(.asymmetric(insertion:.move(edge: .top), removal: .move(edge: .top)))
            }
        }
    }
}
#Preview {
    homwView()
}
