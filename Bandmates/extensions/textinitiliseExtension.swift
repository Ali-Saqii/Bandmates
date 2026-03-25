//
//  textinitiliseExtension.swift
//  Bandmates
//
//  Created by Mac mini on 25/03/2026.
//

import Foundation
import SwiftUI
extension String {
    var initials: String? {
        let formatter = PersonNameComponentsFormatter()
        guard let components = formatter.personNameComponents(from: self) else {
            return nil
        }
        formatter.style = .abbreviated
        return formatter.string(from: components)
    }
}
