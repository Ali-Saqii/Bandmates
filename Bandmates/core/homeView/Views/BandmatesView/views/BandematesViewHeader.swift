//
//  BandematesViewHeader.swift
//  Bandmates
//
//  Created by Mac mini on 23/03/2026.
//

import SwiftUI

struct BandematesViewHeader: View {
    @Binding var selectedTab: BandmatesviewTabs
    
    var body: some View {
       
            HStack(spacing:0) {
                ForEach(BandmatesviewTabs.allCases, id: \.rawValue) { tab in
                    BandmatesHeaderButtons(
                        tab:tab ,
                        isSelected: selectedTab == tab,
                        action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedTab = tab
                            }
                        },
                        height: 38,
                        cornerRadius: 16)
                }
            }.frame(maxWidth: .infinity)
                .frame(height: 38)
                .background(.textfieldcolor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
                .background(.white)
        }
    }

#Preview {
    BandematesViewHeader(selectedTab: .constant(BandmatesviewTabs.myBand))
}
