//
//  albumsRowView.swift
//  Bandmates
//
//  Created by Mac mini on 27/03/2026.
//

import SwiftUI

struct albumsRowView: View {
    let album: albumModel
    let ButtonAction: () -> Void
    var body: some View {
        HStack {
            AsyncImage(url: URL(string:album.image)) { phase in
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
                Text(album.albumName)
                    .font(.callout)
                    .fontWeight(.semibold)
                HStack(spacing:5) {
                    Image("artist")
                        .tint(Color.background)
                    Text(album.albumArtistName)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.background)
                }.frame(height: 16)
                HStack(spacing:5) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    Text("\(album.averageRating , specifier: "%.1f")")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.background)
                    Text("(\(album.totalRatingCount) ratings)")
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
            .shadow(color: .textfieldcolor.opacity(0.5), radius: 12)
            .overlay(alignment:.trailing) {
                Image(systemName: "trash.fill")
                    .foregroundStyle(.white)
                    .padding(.all,8)
                    .onTapGesture {
                        ButtonAction()
                    }
                    .background(
                        Circle()
                            .fill(.red)
                    )
                    .padding(.trailing)
            }
            
    }
}

#Preview {
    albumsRowView(album:DeveloperPreview.instance.album, ButtonAction: {print("fdjkfh dsfds")})
}
