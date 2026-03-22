//
//  BandmatesRowView.swift
//  Bandmates
//
//  Created by Mac mini on 20/03/2026.
//

import SwiftUI

struct BandmatesRowView: View {
    let personImage: String
    let PersonName: String
    let personUserName: String
    @Binding var isRequested : Bool
    var initialise: String? {
        let formatter = PersonNameComponentsFormatter()
        guard let components = formatter.personNameComponents(from: PersonName) else {
            return nil
            
        }
        formatter.style = .abbreviated
        return formatter.string(from: components)
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: personImage)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    Text(initialise ?? "")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 53, height: 53)
                        .background(
                            Circle()
                                .fill(.secondary.opacity(0.6))
                        )
                } else if personImage.isEmpty {
                    Text(initialise ?? "")
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
                    .font(.callout)
                    .fontWeight(.semibold)
                Text("@" + personUserName)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            Spacer()
            requestButton(
                title: "Send Request",
                title2: "waiting to jam",
                action: {
                    withAnimation(.spring) {
                        isRequested.toggle()
                    }
                },
                height: 27,
                width: 95,
                font: .caption2,
                cornerRadius: 25,
                isRequested: isRequested
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
    }
}

#Preview {
    BandmatesRowView(personImage: "", PersonName: "jhfgjd", personUserName: "dfgfdg", isRequested: .constant(false))
}
