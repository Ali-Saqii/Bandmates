//
//  chooseSubscriptionView.swift
//  Bandmates
//
//  Created by Mac mini on 15/03/2026.
//

import SwiftUI

struct chooseSubscriptionView: View {
    @State private var club = true
    @State private var arena = false
    @State private var stadium = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            ScrollView {
                VStack(spacing: 35) {
                    crossButton(action: {})
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text("Choose the right plan for you")
                            .font(.system(size: 20,weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        subscriptionHeaderView
                    }
                    if club {
                        clubMembershipView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            ))
                    }else if arena {
                        arenasubscriptionView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            ))
                    }else if stadium {
                        stadiumSubscriptionView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            ))
                    }
                }.padding(.horizontal)
            }.scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .scrollBounceBehavior(.basedOnSize)
        }
    }
}
extension chooseSubscriptionView {
    private var subscriptionHeaderView: some View {
        VStack(alignment: .leading) {
            HStack(spacing:20) {
                HStack(spacing: 0) {
                    planSelectionCircularButton(isSelected: $club, action: {
                        withAnimation(.easeIn) {
                            club = true
                            arena = false
                            stadium = false
                        }
                    })
                    Text("Club Membership")
                        .font(.system(size: 14,weight: .regular))
                }
                HStack(spacing: 0) {
                    planSelectionCircularButton(isSelected: $arena, action: {
                        withAnimation(.easeIn) {
                            club = false
                            arena = true
                            stadium = false
                        }
                    })
                    Text("Arena Membership")
                        .font(.system(size: 14,weight: .regular))
                }
            }
            HStack(spacing: 0) {
                planSelectionCircularButton(isSelected: $stadium, action: {
                    withAnimation(.easeIn) {
                        club = false
                        arena = false
                        stadium = true
                    }
                })
                Text("Stadium Membership")
                    .font(.system(size: 14,weight: .regular))
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
#Preview {
    chooseSubscriptionView()
}
