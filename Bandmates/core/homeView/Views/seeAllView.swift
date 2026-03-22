//
//  seeAllView.swift
//  Bandmates
//
//  Created by Mac mini on 19/03/2026.
//

import SwiftUI

struct seeAllView: View {
    let text:String
    var body: some View {
        Text(text.capitalized)
            .font(.title3)
            .fontWeight(.semibold)    }
}

#Preview {
    seeAllView(text: "recently played")
}
