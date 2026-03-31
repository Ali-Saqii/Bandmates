//
//  personBandMateView.swift
//  Bandmates
//
//  Created by Mac mini on 30/03/2026.
//

import SwiftUI

struct personBandMateView: View {
    let bandmates: [BandmateModel]
    let name: String
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    if !bandmates.isEmpty {
                        ForEach(bandmates) { bandmate in
                            MyBandRowView(personImage: bandmate.image, fullName: bandmate.fullName, userName: bandmate.userName)
                        }
                        
                    } else {}
                }
            }.scrollIndicators(.hidden)
                
        }.navigationTitle("\(name)'s Bandmates")
    }
}

#Preview {
    personBandMateView(bandmates: DeveloperPreview.instance.Bandmates, name: DeveloperPreview.instance.profile.fullName)
}
