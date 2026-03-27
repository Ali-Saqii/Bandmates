//
//  CollectionAlbumsView.swift
//  Bandmates
//
//  Created by Mac mini on 27/03/2026.
//

import SwiftUI

struct CollectionAlbumsView: View {
    let Collection: CollectionModel
    @State private var ellipseTab = false
    @State private var editCollection = false
    @State private var DeleteCollection = false
    @State private var CollectionNewName = ""
    @State private var CollectionNewDescriptione = ""
    @EnvironmentObject var homeVm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
            ZStack {
                Color.white
                    .ignoresSafeArea(.all)
                ScrollView {
                    VStack {
                        ForEach(Collection.albums){ album in
                            albumsRowView(album: album, ButtonAction: {})
                        }
                    }.padding()
                       
                }.scrollIndicators(.hidden)
                    .onTapGesture {
                        ellipseTab = false
                    }
                if editCollection {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation() {
                                editCollection = false
                            }
                        }
                  reuseablePopup(
                    collectionTitle: $CollectionNewName,
                    description: $CollectionNewDescriptione,
                    popupTitle: "Edit Your Collection",
                    titlePlaceHolder: (homeVm.user.Collections.first?.collectionTitle)!,
                    testEditorPlaceHolder: (homeVm.user.Collections.first?.collectionDescription)!,
                    buttonAction: {},
                    buttonTitle: "Save Changes",
                    dismiss: $editCollection
                  ).transition(AnyTransition.asymmetric(insertion:.scale, removal:.move(edge: .leading)))
                }
                if DeleteCollection {
                    reUsableBottomSheet(
                        sheetTitle: "Delete Collection",
                        sheetWarning: "Are you sure want to delete this collection",
                        buttonTitle1: "cancel",
                        buttonTitle2: "Yes,Delete",
                        button1Action: {},
                        button2Action: {},
                        button1Role: .cancel,
                        button2Role: .destructive, showSheet: $DeleteCollection
                    ).transition(AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal:.move(edge: .bottom)))
                }
            }.environmentObject(homeVm)
        
            .navigationBarBackButtonHidden(true)
            .navigationTitle(Collection.collectionTitle)
                .onTapGesture {
                    ellipseTab = false
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                            .onTapGesture {
                                dismiss()
                            }
                    }.sharedBackgroundVisibility(.hidden)
                    ToolbarItem(placement: .topBarTrailing) {
                        ZStack(alignment:.trailing) {
                            Image(systemName: "ellipsis")
                                .rotationEffect(Angle(degrees: 90))
                                .foregroundStyle(.black)
                                .onTapGesture {
                                    withAnimation {
                                        ellipseTab.toggle()
                                    }
                                }
                            if ellipseTab {
                                menuView.onTapGesture {
                                    
                                }
                            }
                        }
                    }.sharedBackgroundVisibility(.hidden)
          
                }
        }
    }

extension CollectionAlbumsView {
    private var menuView: some View{
        VStack(alignment:.leading) {
            Button {
                withAnimation {
                ellipseTab = false    // ✅ Close the menu
                editCollection = true
                }
            } label: {
                Text("Edit Collection")
                    .font(.dmSans(11, weight: .semiBold))
                    .padding(.all,2.5)
            }
            Button {
                ellipseTab = false    // ✅ Close the menu
                DeleteCollection = true
            } label: {
                Text("Delete Collection")
                    .font(.dmSans(11, weight: .semiBold))
                    .padding(.all,2.5)
            }
        }.padding(.all,5)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .textfieldcolor, radius: 10)
            .offset(x:-10,y: 10)
    }
}
#Preview {
    CollectionAlbumsView(Collection: DeveloperPreview.instance.collection)
        .environmentObject(HomeViewModel())
}


