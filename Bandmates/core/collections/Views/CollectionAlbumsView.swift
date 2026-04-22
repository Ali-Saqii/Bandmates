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
    @State private var reMoveAlbum = false
    @State private var CollectionNewName = ""
    @State private var CollectionNewDescriptione = ""
    @EnvironmentObject var homeVm: HomeViewModel
    @EnvironmentObject var collectionVm : collectionViewModel
    @Environment(\.dismiss) var dismiss
    @State private  var selectedAbbum: albumModel? = nil
    @State private var sjowAlbumDetails = false
    @State private var getId = ""
    var body: some View {
            ZStack {
                Color.white
                    .ignoresSafeArea(.all)
                ScrollView {
                    VStack {
                        ForEach(Collection.albums){ album in
                            albumsRowView(album: album, ButtonAction: {
                                withAnimation() {
                                    getId = album.id
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        reMoveAlbum.toggle()
                                        DeleteCollection = false
                                        ellipseTab = false
                                        editCollection = false
                                    }
                                }
                            }).onTapGesture {
                                selectedAbbum = album
                            }
                        }
                    }.padding()
                       
                }.scrollIndicators(.hidden)
                    .onTapGesture {
                        ellipseTab = false
                    }
                    .onChange(of: collectionVm.isUpdated) { _, newValue in
                        if newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                CollectionNewName = ""
                                CollectionNewDescriptione = ""
                                editCollection = false
                            }
                        }
                    }
                    .onChange(of: collectionVm.isDeleted) { _, newValue in
                        if newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                DeleteCollection = false
                                collectionVm.isDeleted = false
                                dismiss()
                            }
                        }
                        }
                    .onChange(of: collectionVm.removeAlbumSuccess) { _, newValue in
                        if newValue {
                            withAnimation() {
                                reMoveAlbum = false
                                collectionVm.removeAlbumSuccess = false
                            }
                        }
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
                    titlePlaceHolder: Collection.collectionTitle,
                    testEditorPlaceHolder: Collection.collectionDescription,
                    buttonAction: {
                        collectionVm.updateCollection(id: Collection.id, name: CollectionNewName, description: CollectionNewDescriptione)
                    },
                    buttonTitle: "Save Changes",
                    dismiss: $editCollection
                  ).transition(AnyTransition.asymmetric(insertion:.scale, removal:.move(edge: .leading)))
                }
                if DeleteCollection {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation() {
                                DeleteCollection = false
                            }
                        }
                    reUsableBottomSheet(
                        sheetTitle: "Delete Collection",
                        sheetWarning: "Are you sure want to delete this collection",
                        buttonTitle1: "cancel",
                        buttonTitle2: "Yes,Delete",
                        button1Action: {
                            withAnimation() {
                                DeleteCollection = false
                            }
                        },
                        button2Action: {
                            collectionVm.deleteCollection(id: Collection.id)
                            
                        },
                        button1Role: .cancel,
                        button2Role: .destructive 
                    ).transition(AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal:.move(edge: .bottom)))
                }
                if reMoveAlbum {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation() {
                                reMoveAlbum = false
                            }
                        }
                    reUsableBottomSheet(
                        sheetTitle: "Remove Album",
                        sheetWarning: "Are you sure want to remove this album from your collectin",
                        buttonTitle1: "cancel",
                        buttonTitle2: "Yes,Remove",
                        button1Action: {
                            withAnimation() {
                                reMoveAlbum = false
                            }
                        },
                        button2Action: {
                            collectionVm.removeAlbum(albumId: getId, collectionId: Collection.id)
                            if Collection.albums.count == 1 && collectionVm.removeAlbumSuccess {
                                dismiss()
                            }
                        },
                        button1Role: .cancel,
                        button2Role: .destructive
                    ).transition(AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal:.move(edge: .bottom)))
                }
            }.environmentObject(homeVm)
            .navigationDestination(item: $selectedAbbum, destination: { album in
                AlbumDetailsView(album: album)
                .environmentObject(homeVm)
            })
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
                withAnimation() {
                    ellipseTab = false    // ✅ Close the menu
                    DeleteCollection = true
                }
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
        .environmentObject(collectionViewModel())
}


