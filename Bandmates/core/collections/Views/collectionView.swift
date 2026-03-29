//
//  collectionView.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import SwiftUI

struct collectionView: View {
    @EnvironmentObject var homeVm : HomeViewModel
    @State private var searchText = ""
    @State private var showAddCollection = false
    @State private var showEditCollection = false
    @State private var DeleteCollection = false
    @State private var CollectionName = ""
    @State private var CollectionDescriptione = ""
    @State private var CollectionNewName = ""
    @State private var CollectionNewDescriptione = ""
    @State private var selesctedCollection: CollectionModel? = nil
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            VStack() {
                HStack(spacing:10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                        .padding(.leading)
                        .onTapGesture {
                            print(searchText)
                        }
                    TextField("Search Any Collection here ...", text: $searchText)
                }.frame(maxWidth:.infinity)
                    .frame(height: 60)
                    .background(Color.textfieldcolor.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal,20)
                ScrollView{
                    VStack(spacing:15) {
                        ForEach(homeVm.user.Collections) { collection in
                            CollectiomRowView(Collection: collection, editAction: {
                                withAnimation() {
                                    showEditCollection.toggle()
                                }
                            }, DeleteActin:{
                                withAnimation(){
                                    DeleteCollection.toggle()
                                }
                            }, ontapGesture: {selesctedCollection = collection})
                        }
                    }.padding(.horizontal)
                }.scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
                    .padding(.top)
            }
            .overlay(alignment:.bottomTrailing) {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 54, height: 54)
                    .background(
                        Circle()
                            .fill(Color.background)
                    )
                    .onTapGesture {
                        withAnimation() {
                            showAddCollection.toggle()
                        }
                    }
                    .offset(x: -20, y:-10)
            }
            if showAddCollection {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation() {
                            showAddCollection = false
                        }
                    }
              reuseablePopup(
                collectionTitle: $CollectionName,
                description: $CollectionDescriptione,
                popupTitle: "Add New Collection",
                titlePlaceHolder: "Collection Title",
                testEditorPlaceHolder: "Description (write about collection)",
                buttonAction: {},
                buttonTitle: "Create",
                dismiss: $showAddCollection
              ).environmentObject(homeVm)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .move(edge: .leading)))
            }
            if showEditCollection {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation() {
                            showEditCollection = false
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
                dismiss: $showEditCollection
              ).environmentObject(homeVm)
                    .transition(AnyTransition.asymmetric(insertion:.scale, removal:.move(edge: .leading)))
            }
        }.navigationDestination(item: $selesctedCollection) { collection in
            CollectionAlbumsView(Collection: collection)
                .environmentObject(homeVm) 
        }.fullScreenCover(isPresented: $DeleteCollection, content: {
            ZStack {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        DeleteCollection = false
                    }
                reUsableBottomSheet(
                    sheetTitle: "Delete Collection",
                    sheetWarning: "Are you sure want to delete this collection",
                    buttonTitle1: "cancel",
                    buttonTitle2: "Yes,Delete",
                    button1Action: {},
                    button2Action: {},
                    button1Role: .cancel,
                    button2Role: .destructive
                )
            }
            .background(ClearBackgroundView())
        })
        .environmentObject(homeVm)
    }
}


#Preview {
    collectionView()
        .environmentObject(HomeViewModel())
}

