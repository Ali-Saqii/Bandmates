//
//  orthersProfile.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct orthersProfile: View {
    @EnvironmentObject var Bvm : BandMatesViewModel
    let bandmate: BandmateModel?
    @State private var showBandmates = false
    @State private var collectionCount = 0
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            if let bandMate = bandmate {
                VStack(spacing:15) {
                    VStack(alignment:.center) {
                        AsyncImage(url: URL(string: "http://localhost:3000/\(bandMate.image)")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                            } else if phase.error != nil {
                                Text(bandMate.fullName.initials ?? "")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: 80, height: 80)
                                    .background(
                                        Circle()
                                            .fill(.secondary.opacity(0.6))
                                    )
                            } else if bandMate.image.isEmpty {
                                Text(bandMate.fullName.initials ?? "")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: 80, height: 80)
                                    .background(
                                        Circle()
                                            .fill(.secondary.opacity(0.6))
                                    )
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.leading)
                        Text(bandMate.fullName)
                            .foregroundStyle(.black)
                            .font(.dmSans(18, weight: .semiBold))
                        Text(bandMate.userName)
                            .foregroundStyle(.gray)
                            .font(.dmSans(14, weight: .medium))
                        Text(bandMate.Bio)
                            .foregroundStyle(.gray)
                            .font(.dmSans(14, weight: .medium))
                            .lineLimit(1)
                            .frame(width: 250)
                    }
                    HStack() {
                        Spacer()
                        VStack {
                            Text("\(bandmate?.bandmates ?? 0)")
                                .foregroundStyle(.black)
                                .font(.dmSans(16, weight: .semiBold))
                            Text("Bandmates")
                                .foregroundStyle(.black)
                                .font(.dmSans(14, weight: .medium))
                            
                        }
                        .onTapGesture {
                            showBandmates.toggle()
                        }
                        Spacer()
                        VStack {
                            Text("\(bandmate?.collections ?? 0)")
                                .foregroundStyle(.black)
                                .font(.dmSans(16, weight: .semiBold))
                            Text("Collections")
                                .foregroundStyle(.black)
                                .font(.dmSans(14, weight: .medium))
                        }
                        Spacer()
                    }.padding(.horizontal,40)
                    if !bandMate.isRequested && !bandMate.aretheyRequested {
                        buttonView(action: {}, buttonText: "Send Band Request", height: 55)
                            .padding(.horizontal,40)
                    } else if bandMate.aretheyRequested {
                        buttonView(action: {}, buttonText: "Accecpt Request", height: 55)
                            .padding(.horizontal,40)
                    }
                    VStack {
                        Text("Saved Collections")
                            .foregroundStyle(Color.background)
                            .font(.dmSans(16, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        Divider()
                            .overlay(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.background)
                                    .frame(width: 149, height: 3)
                                    .padding(.leading,11)
                            }
                    }
                    VStack {
                        ScrollView {
                            if Bvm.userSavedAlbums == [] {
                                NoBandmatesView(icon: "photo.artframe", height: 60, width: 60, title: "User have no SavedAlbum", subTitle: "User have still no saved albums", titleFont: .dmSans(16, weight: .bold), subTitleFont: .dmSans(12, weight: .medium), color: Color.background.opacity(0.6))
                            } else {
                                ForEach(Bvm.userSavedAlbums) { album in
                                    AlbumsRowView(albumImage: album.albumName, albumName: album.albumName, artistName: album.albumArtistName, ratingCount: album.averageRating, totalRatingcount: album.totalRatingCount, isAlBumSaved: album.isSaved)
                                }
                            }
                        }.scrollIndicators(.hidden)
                    }
                }
            } else {}
        }.navigationTitle("orther's profile".capitalized)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showBandmates) {
//                personBandMateView(bandmates: bandmate?.BandMates ?? [], name: bandmate?.fullName ?? "")
            }
    }
    private func getcollectionCount(count: Int) {
       collectionCount = collectionCount + count
    }
}

#Preview {
    orthersProfile(bandmate: DeveloperPreview.instance.Bandmate)
        .environmentObject(BandMatesViewModel())
}
