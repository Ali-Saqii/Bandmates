//
//  AlbumsRowView.swift
//  Bandmates
//
//  Created by Mac mini on 20/03/2026.
//

import SwiftUI

struct AlbumsRowView: View {
    let albumImage: String
    let albumName:String
    let artistName: String
    let ratingCount: Double
    let totalRatingcount: Int
    @Binding var isAlBumSaved: Bool
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string:albumImage)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 74, height: 78)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                } else if phase.error != nil {
                    Image("placeholderImage")
                        .frame(width: 74, height: 78)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        ).background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    LinearGradient(colors: [Color.orange,Color.pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .strokeBorder(Color.background,lineWidth: 2)
                        )
                    
                } else {
                    ProgressView()
                        .frame(width: 74, height: 78)
                }
            }.padding(.leading,7)
            VStack(alignment:.leading,spacing:6) {
                Text(albumName)
                    .font(.callout)
                    .fontWeight(.semibold)
                HStack(spacing:5) {
                    Image("artist")
                        .tint(Color.background)
                    Text(artistName)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.background)
                }.frame(height: 16)
                HStack(spacing:5) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    Text("\(ratingCount , specifier: "%.1f")")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.background)
                    Text("(\(totalRatingcount) ratings)")
                        .font(.system(size: 10))
                        .foregroundStyle(Color.background)
                }.frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 16)
            }
            
        }.frame(maxWidth: .infinity,alignment: .leading)
            .frame(height: 98)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .overlay(alignment: .trailing, content: {
                albumSaveButton(isSaved: isAlBumSaved) {
                    withAnimation(.easeIn){
                        isAlBumSaved.toggle()
                    }
                    
                }
                .padding(.trailing,20)
             
            })
            .shadow(color: Color.textfieldcolor.opacity(0.7), radius: 5)
            .padding(.horizontal)
    }
}

#Preview {
    AlbumsRowView(albumImage: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400",
                  albumName: "",
                  artistName: "",
                  ratingCount: 4.5,
                  totalRatingcount: 89, isAlBumSaved: .constant(true)
)
}
