//
//  AlbumFeddBackView.swift
//  Bandmates
//
//  Created by Mac mini on 26/03/2026.
//

import SwiftUI

struct AlbumFeddBackView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var hvm: HomeViewModel
    let albumImage: String
    let albumName: String
    let artistName: String
    let ratingCount: Double
    let totalRatingcount: Int
    @Binding var isAlBumSave: Bool
    @State var starCount = 0
    @State private var feddBackText = ""
    @State private var feedBackPlaceHolder = "How was your experience?"

    var ratingText : String? {
        if starCount == 0   { return ""} else if starCount == 1   { return "Average"
        } else if starCount == 2   { return "Average"
        } else if starCount == 3   { return "Interseted"
        } else if starCount == 4   { return "Good"
        }else if starCount == 5   {return "Excellent"
        } else {
            return ""
        }
    }
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing:20) {
              AlbumsRowView(albumImage: albumImage, albumName: albumName, artistName: artistName, ratingCount: ratingCount, totalRatingcount: totalRatingcount, isAlBumSaved: isAlBumSave)
                Text("Please rate your experience with this album.")
                    .font(.dmSans(20, weight: .semiBold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text(ratingText ?? "")
                    .foregroundStyle(Color.background)
                    .font(.dmSans(20, weight: .semiBold))
                ratingStarsView(count: $starCount, font: .title, Color: Color.background)
    
                Text("Your Feedback")
                    .font(.dmSans(20, weight: .semiBold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal)
                
                TextEditor(text: $feddBackText)
                    .padding(.horizontal)
                    .frame(height: 200)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal)
                       .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.textfieldcolor.opacity(0.3))
                            .padding(.horizontal)
                       )
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                            .stroke(Color.inputBorder, lineWidth: 1)
                            .padding(.horizontal)
                            .overlay(alignment:.topLeading) {
                                Text(feedBackPlaceHolder)
                                    .font(.callout)
                                    .foregroundStyle(.gray.opacity(0.7))
                                    .padding(.horizontal)
                                    .padding()
                            }.onTapGesture {
                                feedBackPlaceHolder = ""
                            }
                    })
                buttonView(action: {}, buttonText: "Submit Review", height: 50)
                    .padding()
                    .padding(.horizontal)
                Spacer()
            }
        }.navigationTitle("Album Feedback")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.topBarLeading) {
                    crossButton(action: { dismiss() })
                        
                }.sharedBackgroundVisibility(.hidden)
            }
    }
}
#Preview {
    AlbumFeddBackView( albumImage:  "https://images.unsplash.com/photo-1463453091185-61582044d556?w=400", albumName: "For All The Dogs", artistName: "Drake", ratingCount: 4.9, totalRatingcount: 111, isAlBumSave: .constant(false)
    )
    .environmentObject(HomeViewModel())
}
