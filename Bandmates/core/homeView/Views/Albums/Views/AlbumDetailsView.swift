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
    @State var showComments: Bool = false
    let album: albumModel
    @State private var showGiveRatingView = false
    @State private var SaveAlbum = false
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
                                        if !album.reviews.isEmpty {
                                            ForEach(album.reviews) { review in
                                                reviewsView(reView: review)
                                            }
                                        }else {
                                            NoBandmatesView(icon: "exclamationmark.message.fill", height: 50, width: 70, title: "No reviews yet".capitalized, subTitle: "Give feddback on this album to get review", titleFont: .dmSans(18, weight: .semiBold), subTitleFont: .dmSans(16, weight: .medium), color: Color.background)
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
                .navigationDestination(isPresented: $showGiveRatingView) {
                    AlbumFeddBackView(albumId: album.id,
                        albumImage: album.image, albumName: album.albumName, artistName: album.albumArtistName, ratingCount: album.averageRating, totalRatingcount: album.totalRatingCount, isAlBumSave: $isSaved
                    )
                    .environmentObject(hvm)
                }.onAppear {
                    isAlbumSaved()
                    albumRating()
                }
            if SaveAlbum {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        SaveAlbum = false
                    }
                SaveAlbumPopover( showPopUp: $SaveAlbum, albumId: album.id)
                    .environmentObject(hvm)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
            }
        }.sheet(isPresented: $showComments) {
            commentsView(albumId: album.id, comments: album.replies)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .environmentObject(hvm)
        }
        .environmentObject(hvm)
    }

    @State var isSaved : Bool  = false
    private func isAlbumSaved() {
        self.isSaved = album.isSaved
    }
  @State private  var rating : Int  = 0
    private func albumRating() {
        self.rating = Int(album.averageRating)
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
                ratingStarsView(count: $rating, font:.system(size: 14), Color: .yellow)
                    .overlay {
                        Rectangle()
                            .fill(.white.opacity(0.1))
                    }
                HStack(spacing:0) {
                    Text("\(album.averageRating ,specifier: "%.1f")")
                        .font(.dmSans(14, weight: .medium))
                    Text("(\(album.totalRatingCount) ratings)")
                        .foregroundStyle(.gray)
                        .font(.dmSans(14, weight: .regular))
                }
                Spacer()
                requestButton(title: "give rating".capitalized, title2: "give ratings".capitalized, action: {
                    showGiveRatingView = true
                }, height: 30, width: 100, font: .dmSans(14, weight: .regular), cornerRadius: 25, isRequested: false)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
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
   

    private var buttionsView: some View {
        HStack {

            detailsViewButtons(icon1: "heart", icon2: "heart.fill", title: "Save", action: {
                if album.isSaved == false {
                    withAnimation() {
                        SaveAlbum.toggle()
                    }
                }
            }, isSelected: album.isSaved)
            Spacer()

            detailsViewButtons(icon1: "ellipsis.message", icon2: "ellipsis.message.fill", title: "\(album.replies.count) comments", action: {
        
                    showComments.toggle()
                
            }, isSelected: showComments)
            Spacer()
            detailsViewButtons(icon1: "square.and.arrow.up", icon2: "square.and.arrow.up.fill", title: "Share", action: {hvm.shareAlbum(album)}, isSelected: false)
        }.padding(.horizontal,30)
    }
    private var playButtonView: some View {
        buttonView(action: {
            hvm.addTorecentlyPlayed(album: album)
            hvm.openLink(album.albumPlayLink)
        }, buttonText: "play AlBum".capitalized, height: 50)
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
    AlbumDetailsView(
        album: albumModel(
            id: "1",
            image: "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=400",
            albumName: "For All The Dogs",
            albumArtistName: "Drake",
            releaseDate: ISO8601DateFormatter().date(from: "2023-10-06T00:00:00Z")!,
            averageRating: 3.9,
            totalRatingCount: 142100,
            reviews: [
                reviewsModel(
                    id: "r1",
                    personImage: "user6",
                    personName: "Andre P.",
                    dateOfRating: ISO8601DateFormatter().date(from: "2023-10-07T10:00:00Z")!,
                    rating: 4.0,
                    reviewBody: "Rich Flex and Hours in Silence are the highlights for me."
                ),
                reviewsModel(
                    id: "r2",
                    personImage: "user6",
                    personName: "Andre P.",
                    dateOfRating: ISO8601DateFormatter().date(from: "2023-10-07T10:00:00Z")!,
                    rating: 4.0,
                    reviewBody: "Rich Flex and Hours in Silence are the highlights for me."
                )
            ],
            replies: [
                CommentModel(
                    id: "c1",
                    image: "user6",
                    name: "Andre P.", disPlayName: "jfdghfjkdgh",
                    replieText: "Rich Flex and Hours in Silence are the highlights for me.",
                    replieTime: ISO8601DateFormatter().date(from: "2023-10-07T10:00:00Z")!
                )
            ],
            isSaved: true,
            albumPlayLink: ""
        )
    )
    .environmentObject(HomeViewModel())
    
}
