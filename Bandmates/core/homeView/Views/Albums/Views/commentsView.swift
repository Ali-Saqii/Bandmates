//
//  commentsView.swift
//  Bandmates
//
//  Created by Mac mini on 25/03/2026.
//

import SwiftUI

struct commentsView: View {
    @EnvironmentObject private var hvm : HomeViewModel
    let albumId: String
    @State private var commentText = ""
    var comments : [CommentModel]
    @State private var id: String? = nil
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            ScrollView {
                if !comments.isEmpty {
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
                                    VStack(alignment:.leading) {
                                        if let nam = comment.disPlayName {
                                            Text(nam)
                                                .font(.dmSans(14, weight: .medium))
                                                .foregroundStyle(.blue)
                                        }
                                        Text(comment.replieText)
                                            .font(.dmSans(12, weight: .medium))
                                    }
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
                                            getId(comment: comment)
                                            isTextFieldFocused = true
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
                }else {
                    NoBandmatesView(icon: "exclamationmark.message.fill", height: 50, width: 70, title: "No comments yet".capitalized, subTitle: "comment on this album to get comments", titleFont: .dmSans(18, weight: .semiBold), subTitleFont: .dmSans(16, weight: .medium), color: Color.background)
                        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
                }
            }.scrollIndicators(.hidden)
                .overlay(alignment:.bottom) {
                    HStack(alignment:.center,spacing: 15) {
                        TextField("", text: $commentText,axis: .vertical)
                            .focused($isTextFieldFocused)
                            .keyboardType(.default)
                            .padding(.horizontal)
                            .padding(.vertical,15)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.textfieldcolor.opacity(0.9))
                                
                            )
                        Button {
                            sendComment()
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundStyle(.white)
                                .padding()
                        }.background(
                            Circle()
                                .fill(Color.background)
                        )
                        
                    }.padding(.horizontal)
                }.overlay {
                    if hvm.isLoading {
                        Rectangle()
                            .fill(.textfieldcolor.opacity(0.5))
                            .ignoresSafeArea()
                            .overlay {
                                ProgressView().tint(Color.background)
                            }
                    }
                }
        }

         
    }
    
    private func sendComment() {
        hvm.postComment(albumId: albumId, text: commentText, parentId: id)
    }
    private func getId(comment: CommentModel){
        id = comment.id
    }

}
#Preview {
    commentsView(albumId: "", comments: [
        CommentModel(id: "", image: "user6", name: "Sophie T.", disPlayName: "cvcxv", replieText: "The smallest man whojjf dsjjdsjdfhjf  ever lived deserved its own album.", replieTime: ISO8601DateFormatter().date(from: "2024-04-21T16:00:00Z")!)
    ])
    .environmentObject(HomeViewModel())
}
