//
//  homwView.swift
//  Bandmates
//
//  Created by Mac mini on 12/03/2026.
//

import SwiftUI

struct homwView: View {
    @EnvironmentObject var homeVm: HomeViewModel
    @State private var recentlyPlayedSeeAll = false
    @State private var recommendedAlbumsSeeAll = false
    @State private var seeAllBandmates = false
    @State private var search = false
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
        }.navigationDestination(isPresented: $seeAllBandmates) {
            Bandmates()
                .environmentObject(HomeViewModel())
        }
        .navigationDestination(isPresented: $recommendedAlbumsSeeAll) {
            albumsView()
                .environmentObject(HomeViewModel())
        }
        .navigationDestination(isPresented: $recentlyPlayedSeeAll) {
            recentlyPlayedAlbums()
                .environmentObject(HomeViewModel())
        }
        .navigationDestination(isPresented: $search) {
            searchResults()
                .environmentObject(HomeViewModel())
        }
    }
}

extension homwView {
    private var greetinTextView: some View {
        HStack {
            Text("hey \(homeVm.user.fullName),".capitalized)
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
               
        }.frame(maxWidth:.infinity)
            .frame(height: 60)
            .background(Color.textfieldcolor.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal,20)
            .overlay(content: {
                Rectangle()
                    .fill(.white.opacity(0.01))
                    .onTapGesture {
                        search.toggle()
                    }
            })
            
    }
    private var recentlyPlayedButtonView: some View {
        HStack {
            seeAllView(text: "recently Played")
            Spacer()
            seeAllButtonView(isSeeAll: $recentlyPlayedSeeAll)
        }.padding(.horizontal)
    }
    private var recentlyPlayedAlbumsView: some View {
            HStack(spacing:20) {
                ForEach(Array(homeVm.recentlyplayed.prefix(3).indices), id: \.self) { index in
                    recentlyPlayedView(image: homeVm.recentlyplayed[index].image, albumName: homeVm.recentlyplayed[index].albumName)
                }
            }.padding(.horizontal)
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
            ForEach(Array(homeVm.albums.prefix(3).indices), id: \.self) { index in
                NavigationLink {
                    AlbumDetailsView( album: homeVm.albums[index])
                        .environmentObject(homeVm)
                } label: {
                    AlbumsRowView(
                               albumImage: homeVm.albums[index].image,
                               albumName: homeVm.albums[index].albumName,
                               artistName: homeVm.albums[index].albumArtistName,
                               ratingCount: homeVm.albums[index].averageRating,
                               totalRatingcount: homeVm.albums[index].totalRatingCount,
                               isAlBumSaved: homeVm.albums[index].isSaved
                    ).transition(.asymmetric(insertion:.move(edge: .top), removal: .move(edge: .top)))
                }
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
            ForEach( Array(homeVm.bandmates.prefix(3))) { mate in
                NavigationLink {
                    orthersProfile(bandmate: mate)
                } label: {
                    OrtherUsersRowView(
                        personImage: mate.image,
                        PersonName: mate.fullName,
                        personUserName: mate.userName,
                        isRequested: mate.isRequested, buttonAction: {}
                    ).transition(.asymmetric(insertion:.move(edge: .top), removal: .move(edge: .top)))
                }
            }
        }
    }
}
#Preview {
    homwView()
        .environmentObject(HomeViewModel())
}
