//
//  homeViewNotificationButton.swift
//  Bandmates
//
//  Created by Mac mini on 19/03/2026.
//

import SwiftUI

struct homeViewNotificationButton: View {
    let action: () -> Void
    let notificationCount : Int?
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "bell")
                .foregroundStyle(.white)
                .background(
                    Circle()
                        .fill(Color.black)
                        .frame(width: 45, height: 45)
                        .overlay(alignment:.topTrailing) {
                            if let count = notificationCount {
                                Text("\(count)")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .background(
                                        Circle()
                                            .fill(Color.background)
                                            .frame(width: 20, height: 20)
                                    )
                            }
                        }
                )
        }
    }
}

#Preview {
    homeViewNotificationButton(action: {}, notificationCount: 4)
}
