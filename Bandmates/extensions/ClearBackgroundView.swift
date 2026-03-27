//
//  ClearBackgroundView.swift
//  Bandmates
//
//  Created by Mac mini on 28/03/2026.
//

import Foundation
import SwiftUI
struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
