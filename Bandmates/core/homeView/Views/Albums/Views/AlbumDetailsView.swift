//
//  AlbumDetailsView.swift
//  Bandmates
//
//  Created by Mac mini on 24/03/2026.
//

import SwiftUI

struct AlbumDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var hvm: HomeViewModel
    @State var showComments: Bool = true
    let album: albumModel

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
          
                VStack(spacing:10) {
                    albumImageView
                    ScrollView {
                        LazyVStack(spacing: 10,pinnedViews: [.sectionHeaders]) {
                            albumInformationView
                            Divider()
                                .padding(.bottom,5)
                                Section {
                                    VStack(spacing:20) {
                                        Text("Reviews")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal)
                                            .font(.dmSans(20, weight: .bold))
                                        ForEach(album.reviews) { review in
                                            reviewsView(reView: review)
                                        }
                                    }
                                } header: {
                                    VStack {
                                        buttionsView
                                        Divider()
                                        playButtonView
                                        Divider()
                                    }.background(.white)
                                   
                                }
                        }
                
                    }.navigationBarBackButtonHidden(true)
                }.toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        albumDetailsToolBarButton(action: {
                            dismiss()
                        }, iconName: "chevron.left")

                    }.sharedBackgroundVisibility(.hidden)
                    if !album.isSaved {
                        ToolbarItem(placement: .topBarTrailing) {
                            albumDetailsToolBarButton(action: {}, iconName: "heart")
                            
                        }.sharedBackgroundVisibility(.hidden)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        albumDetailsToolBarButton(action: {}, iconName: "ellipsis")

                    }.sharedBackgroundVisibility(.hidden)
                   
                }
        }
    }
}
extension AlbumDetailsView {
    private var albumImageView:some View {
        VStack {
            AsyncImage(url: URL(string: album.image)) { phase in
                phase
                    .resizable()
                    .ignoresSafeArea()
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.5))
                            .ignoresSafeArea()
                            .overlay(alignment:.center) {
                                Text(album.albumName)
                                    .foregroundStyle(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .font(.largeTitle.bold().uppercaseSmallCaps(true))
                                    .lineSpacing(0)
                            }
                        
                    }
            } placeholder: {
                ContentUnavailableView("No image found".capitalized, systemImage: "tray.2.fill")
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.1))
                            .ignoresSafeArea()
                    }
            }

        }.frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.225)
    }
    private var albumInformationView:some View {
        VStack(alignment:.leading,spacing: 5) {
            Text(album.albumName)
                .font(.dmSans(18, weight: .black))
            HStack(spacing:5) {
                Image("artist")
                    .resizable()
                    .frame(width: 15, height: 15)
                Text(album.albumArtistName)
                    .foregroundStyle(Color.background)
                    .font(.dmSans(14, weight: .regular))
            }.frame(height: 16)
            Text("\(album.releaseDate.billingFormatted)")
                .foregroundStyle(.gray)
                .font(.dmSans(14, weight: .regular))
            HStack(spacing:5) {
                ratingStarsView(count: Int(album.averageRating), font:.system(size: 14))
                HStack(spacing:0) {
                    Text("\(album.averageRating ,specifier: "%.1f")")
                        .font(.dmSans(14, weight: .medium))
                    Text("(\(album.totalRatingCount) ratings)")
                        .foregroundStyle(.gray)
                        .font(.dmSans(14, weight: .regular))
                }
                Spacer()
                requestButton(title: "give rating".capitalized, title2: "give ratings".capitalized, action: {}, height: 30, width: 100, font: .dmSans(14, weight: .regular), cornerRadius: 25, isRequested: false)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
    private var buttionsView: some View {
        HStack {

            detailsViewButtons(icon1: "heart", icon2: "heart.fill", title: "Save", action: {}, isSelected: album.isSaved)
            Spacer()

            detailsViewButtons(icon1: "ellipsis.message", icon2: "ellipsis.message.fill", title: "\(14) comments", action: {
                showComments.toggle()
            }, isSelected: showComments)
            Spacer()
            detailsViewButtons(icon1: "square.and.arrow.up", icon2: "square.and.arrow.up.fill", title: "save", action: {}, isSelected: false)
        }.padding(.horizontal,30)
    }
    private var playButtonView: some View {
        buttonView(action: {}, buttonText: "play AlBum".capitalized, height: 50)
            .overlay(content: {
                HStack {
                    Spacer()

                    Image(systemName: "play.fill")
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                        .foregroundStyle(.white)
                    Spacer()


                }
            })
            .padding(.horizontal)
    }
}
#Preview {
    AlbumDetailsView(album: albumModel(
        image: "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=400",
        albumName: "For All The Dogs",
        albumArtistName: "Drake",
        releaseDate: ISO8601DateFormatter().date(from: "2023-10-06T00:00:00Z")!,
        averageRating: 3.9,
        totalRatingCount: 142100,
        reviews: [
            reviewsModel(personImage: "user6", personName: "Andre P.", dateOfRating: ISO8601DateFormatter().date(from: "2023-10-07T10:00:00Z")!, rating: 4.0, reviewBody: "Rich Flex and Hours in Silence are the highlights for me."),
            reviewsModel(personImage: "user7", personName: "Tasha B.", dateOfRating: ISO8601DateFormatter().date(from: "2023-10-08T13:00:00Z")!, rating: 3.5, reviewBody: "Has its moments but too bloated at 23 tracks.")
        ],
        replies: [
            replies(image: "user8", name: "Kevin O.", replieText: "Slime You Out was everywhere that fall.", replieTime: ISO8601DateFormatter().date(from: "2023-10-08T14:00:00Z")!)
        ],
        isSaved: true
    ))
    .environmentObject(HomeViewModel())
}
