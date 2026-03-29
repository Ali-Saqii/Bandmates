//
//  reuseablePopup.swift
//  Bandmates
//
//  Created by Mac mini on 27/03/2026.
//

import SwiftUI

struct reuseablePopup: View {
    @Binding var collectionTitle : String
    @Binding var description: String
    let popupTitle: String
    let titlePlaceHolder : String
    let testEditorPlaceHolder: String
    let buttonAction: () -> Void
    let buttonTitle : String
    @Binding var dismiss: Bool
    var body: some View {
        GeometryReader { geo in
            VStack(spacing:15) {
                HStack {
                    Text("Add New Collection")
                        .font(.dmSans(20, weight: .semiBold))
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.5)) {
                                dismiss = false
                            }
                        }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                InputField(label: "", placeholder: titlePlaceHolder, text: $collectionTitle)
                    .padding(.horizontal)
                reusabletextEditor(text:  $description, PlaceHolder: testEditorPlaceHolder, height: 150, color: .textfieldcolor.opacity(0.3))
                buttonView(action:buttonAction, buttonText: buttonTitle, height: 50)
                    .padding(.horizontal)
            }.frame(maxWidth: .infinity)
                .frame(height: 400)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .textfieldcolor, radius: 10)
                .frame(maxHeight: .infinity, alignment: .center)
                .padding(.horizontal)
                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
        }
    }
}

#Preview {
    reuseablePopup(collectionTitle: .constant(""), description: .constant(""), popupTitle: "add new collection".capitalized, titlePlaceHolder: "Collection Title", testEditorPlaceHolder: "Description (write AboutCollection)",buttonAction: {} ,buttonTitle: "Create", dismiss: .constant(true))
}
