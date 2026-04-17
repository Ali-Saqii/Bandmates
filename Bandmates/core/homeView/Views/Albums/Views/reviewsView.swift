//
//  reviewsView.swift
//  Bandmates
//
//  Created by Mac mini on 24/03/2026.
//

import SwiftUI

struct reviewsView: View {
    let reView: reviewsModel
    var initialise: String? {
        let formatter = PersonNameComponentsFormatter()
        guard let components = formatter.personNameComponents(from: reView.personName) else {
            return nil
            
        }
        formatter.style = .abbreviated
        return formatter.string(from: components)
    }
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            HStack(spacing:5) {
                AsyncImage(url: URL(string: reView.personImage)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Text(initialise ?? "")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(.secondary.opacity(0.6))
                            )
                    } else if reView.personImage.isEmpty {
                        Text(initialise ?? "")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(.secondary.opacity(0.6))
                            )
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                VStack(alignment:.leading) {
                    Text(reView.personName)
                        .font(.dmSans(14, weight: .bold))
                        .fontWeight(.semibold)
                    Text("\(reView.dateOfRating.billingFormatted)")
                        .font(.dmSans(12, weight: .medium))
                        .foregroundStyle(.gray)
                }
                Spacer()
                HStack(spacing:2) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.yellow)
                    Text("\(reView.rating, specifier: "%.1f")")
                        .font(.dmSans(15, weight: .medium))

                }
            }
            Text(reView.reviewBody)
                .foregroundStyle(.gray)
                .font(.dmSans(13, weight: .medium))
                .multilineTextAlignment(.leading)
                .padding(.horizontal,5)
            Divider()
                .padding(.top,10)
                .padding(.horizontal)
        }.frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    reviewsView(reView:   reviewsModel(id: "", personImage: "user4", personName: "Brett H.", dateOfRating: ISO8601DateFormatter().date(from: "2024-03-31T14:00:00Z")!, rating: 4.5, reviewBody: "Daughter and Protector gave me chills. She poured everything into this."))
}
