//
//  commentsView.swift
//  Bandmates
//
//  Created by Mac mini on 25/03/2026.
//

import SwiftUI

struct commentsView: View {
    @EnvironmentObject private var hvm : HomeViewModel
    @State private var commentText = ""
    var comments : [CommentModel]

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            ScrollView {
                VStack(alignment:.leading) {
                    ForEach(comments,id: \.id) { comment in
                        HStack(alignment:.top,spacing: 10) {
                            AsyncImage(url: URL(string: comment.image )) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } else if phase.error != nil {
                                    Text(comment.name.initials ?? "")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(width: 45, height: 45)
                                        .background(
                                            Circle()
                                                .fill(.secondary.opacity(0.6))
                                        )
                                } else if comment.image.isEmpty {
                                    Text(comment.name.initials ?? "")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(width: 45, height: 45)
                                        .background(
                                            Circle()
                                                .fill(.secondary.opacity(0.6))
                                        )
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                            .offset(y: 2)
                            .padding(.leading)
                            VStack(alignment: .leading,spacing: 2) {
                                Text(comment.name)
                                    .font(.dmSans(16, weight: .semiBold))
                                Text(comment.replieText)
                                    .font(.dmSans(12, weight: .medium))
                                    .padding(.all,8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.textfieldcolor.opacity(0.5))
                                    )
                                    .padding(.trailing)
                                HStack() {
                                    Text("\(comment.replieTime.relativeTimeShort)")
                                        .font(.dmSans(12, weight: .medium))
                                    Button {
                                        commentText = "@\(comment.name)\n"
                                    } label: {
                                        Text("reply".capitalized)
                                            .foregroundStyle(.black)
                                            .font(.dmSans(12, weight: .medium))
                                            .padding(.horizontal)
                                    }

                                    
                                }.padding(.horizontal)
                            }
                        }
                    }
                }.padding()
                    .padding(.top)
                    .frame(maxWidth: .infinity,alignment: .leading)
                  
            }.scrollIndicators(.hidden)
                .overlay(alignment:.bottom) {
                    HStack(alignment:.center,spacing: 15) {
                        TextField("", text: $commentText,axis: .vertical)
                            .keyboardType(.default)
                            .padding(.horizontal)
                            .padding(.vertical,15)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.textfieldcolor.opacity(0.9))
                                
                            )
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundStyle(.white)
                                .padding()
                        }.background(
                            Circle()
                                .fill(Color.background)
                        )
                        
                    }.padding(.horizontal)
                }
        }
         
    }
}
#Preview {
    commentsView(comments: [
        CommentModel(image: "user6", name: "Sophie T.", replieText: "The smallest man whojjf dsjjdsjdfhjf  ever lived deserved its own album.", replieTime: ISO8601DateFormatter().date(from: "2024-04-21T16:00:00Z")!)
    ])
}
