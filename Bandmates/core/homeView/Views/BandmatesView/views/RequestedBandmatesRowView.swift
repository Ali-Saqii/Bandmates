//
//  RequestedBandmatesRowView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct RequestedBandmatesRowView: View {
    let personImage : String
    let fullName : String
    let userName : String
    let DeclineButton : () -> Void
    let ApproveButton : () -> Void
    var body: some View {
        HStack {
                AsyncImage(url: URL(string: personImage)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Text(fullName.initials ?? "")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 53, height: 53)
                            .background(
                                Circle()
                                    .fill(.secondary.opacity(0.6))
                            )
                    } else if personImage.isEmpty {
                        Text(fullName.initials ?? "")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 53, height: 53)
                            .background(
                                Circle()
                                    .fill(.secondary.opacity(0.6))
                            )
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 53, height: 53)
                .clipShape(Circle())
                .padding(.leading)
                VStack(alignment:.leading,spacing: 6) {
                    Text(fullName.capitalized)
                        .font(.dmSans(14, weight: .semiBold))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    Text(userName)
                        .font(.dmSans(12, weight: .medium))
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }.frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Button {
                    DeclineButton()
                } label: {
                    Text("Decline")
                        .foregroundStyle(.white)
                        .font(.dmSans(10, weight: .bold))
                        .frame(width: 64, height: 25)
                }.background(.red)
                    .clipShape(Capsule())
                Button {
                    ApproveButton()
                } label: {
                    Text("Approve")
                        .foregroundStyle(.white)
                        .font(.dmSans(10, weight: .bold))
                        .frame(width: 64, height: 25)
                }.background(.green)
                    .clipShape(Capsule())

            }.padding(.trailing)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 73)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .gray.opacity(0.4), radius: 12)
            
        }
    }

#Preview {
    RequestedBandmatesRowView(personImage: "", fullName: "", userName: "", DeclineButton: {}, ApproveButton: {})
}
