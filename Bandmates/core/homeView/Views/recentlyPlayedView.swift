//
//  recentlyPlayedView.swift
//  Bandmates
//
//  Created by Mac mini on 20/03/2026.
//

import SwiftUI

struct recentlyPlayedView: View {
    let image: String
    let albumName: String
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string:image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 102, height: 85)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
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
                            .frame(width: 40, height: 40)
                    }
                }
            }
            .frame(width: 122, height: 105)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 18)
            )
            .shadow(color: Color.textfieldcolor.opacity(0.7), radius: 5)
            Text(albumName)
                .font(.system(size: 14,weight: .bold))
        }
    }
}

#Preview {
    recentlyPlayedView(image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400", albumName: "jkgjkfd jfdj")
}
