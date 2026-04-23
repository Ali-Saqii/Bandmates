//
//  OrtherUsersRowView.swift
//  Bandmates
//
//  Created by Mac mini on 20/03/2026.
//

import SwiftUI

struct OrtherUsersRowView: View {
    let personImage: String
    let PersonName: String
    let personUserName: String
    let isRequested : Bool
    let buttonAction : () -> Void
    @State private var isrequested = false
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "http://localhost:3000/\(personImage)")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    Text(PersonName.initials ?? "")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 53, height: 53)
                        .background(
                            Circle()
                                .fill(.secondary.opacity(0.6))
                        )
                } else if personImage.isEmpty {
                    Text(PersonName.initials ?? "")
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
            VStack(alignment:.leading) {
                Text(PersonName)
                    .foregroundStyle(.black)
                    .font(.callout)
                    .fontWeight(.semibold)
                Text(personUserName)
                    .foregroundStyle(.black)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            Spacer()
            requestButton(
                title: "Send Request",
                title2: "waiting to jam",
                action: {
                    buttonAction()
                },
                height: 27,
                width: 95,
                font: .caption2,
                cornerRadius: 25,
                isRequested: isrequested
            )
            .padding(.horizontal)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 73)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .shadow(color: Color.textfieldcolor.opacity(0.8), radius: 12)
            .padding(.horizontal)
            .onAppear {
                getISRequested()
            }
    }
    private func getISRequested() {
        isrequested = isRequested
    }
}

#Preview {
    OrtherUsersRowView(personImage: "", PersonName: "jhfgjd", personUserName: "dfgfdg", isRequested: true, buttonAction: {})
}
