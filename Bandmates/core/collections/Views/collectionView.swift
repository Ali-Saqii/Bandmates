//
//  collectionView.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import SwiftUI

struct collectionView: View {
    @EnvironmentObject var homeVm : HomeViewModel
    @StateObject var collectionVM = collectionViewModel()
    @State private var searchText = ""
    @State private var showAddCollection = false
    @State private var showEditCollection = false
    @State private var DeleteCollection = false
    @State private var CollectionName = ""
    @State private var CollectionDescriptione = ""
    @State private var CollectionNewName = ""
    @State private var CollectionNewDescriptione = ""
    @State private var selesctedCollection: CollectionModel? = nil
    
    @State private var getId = ""
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
                if collectionVM.isLoading && ((collectionVM.collections?.isEmpty) != nil) {
                    ProgressView()
                        .tint(Color.background)
                        .padding()
                }

                ScrollView{
                    VStack(spacing:15) {
                        if let Collection = collectionVM.collections, !Collection.isEmpty {
                            ForEach(Collection) { collection in
                                CollectiomRowView(Collection: collection, editAction: {
                                    getId = collection.id
                                    withAnimation() {
                                        
                                        showEditCollection.toggle()
                                    }
                                }, DeleteActin:{
                                    getId = collection.id
                                    print(getId)
                                    withAnimation(){
                                        
                                        DeleteCollection.toggle()
                                    }
                                }, ontapGesture: {selesctedCollection = collection})
                                .onAppear {
                                       collectionVM.loadMoreIfNeeded(currentItem: collection) // ← pagination
                                   }
                            }
                            if collectionVM.isFetchingMore {
                                ProgressView().tint(Color.background)
                                    .padding()
                            }
                        }else{
                            NoBandmatesView(icon: "photo.on.rectangle.angled.fill", height: 60, width: 70, title: "no collection yet".capitalized, subTitle: "Add acollection to save desire alums..", titleFont: .dmSans(18, weight: .semiBold), subTitleFont: .dmSans(18, weight: .semiBold), color: Color.background.opacity(0.6))
                        }
                    }.padding(.horizontal)
                }.scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
                    .padding(.top)
                    .onChange(of: collectionVM.successMessage) { _, newValue in
                          if newValue != nil {
                              DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                  CollectionName = ""
                                  CollectionDescriptione = ""
                                  withAnimation() { showAddCollection = false }
                              }
                          }
                      }
                    .onChange(of: collectionVM.isUpdated) { _, newValue in
                        if newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                CollectionNewName = ""
                                CollectionNewDescriptione = ""
                                withAnimation() { showEditCollection = false }
                            }
                        }
                    }
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
                buttonAction: {createButttonFunc()},
                buttonTitle: "Create",
                dismiss: $showAddCollection
                    
              ).overlay(content: {
                  if collectionVM.isLoading {
                      Rectangle()
                          .fill(Color.textfieldcolor.opacity(0.5))
                          .ignoresSafeArea()
                          .overlay {
                              ProgressView()
                          }
                  }
              })
              .environmentObject(homeVm)
                    
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
                titlePlaceHolder: ("Enter new Title"),
                testEditorPlaceHolder: ("enter new Description"),
                buttonAction: {
                    collectionVM.updateCollection(id: getId, name: CollectionNewName, description: CollectionNewDescriptione)
                    
                },
                buttonTitle: "Save Changes",
                dismiss: $showEditCollection
              ).environmentObject(homeVm)
                    .transition(AnyTransition.asymmetric(insertion:.scale, removal:.move(edge: .leading)))
            }
        }.navigationDestination(item: $selesctedCollection) { collection in
            CollectionAlbumsView(Collection: collection)
                .environmentObject(homeVm)
                .environmentObject(collectionVM) 
        }
        
        .fullScreenCover(isPresented: $DeleteCollection, content: {
            ZStack {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .overlay(alignment: .top, content: {
                        if let errormessage = collectionVM.cCErrorMessage {
                            Text(errormessage)
                                .foregroundStyle(.red)
                                .font(.dmSans(14, weight: .medium))
                        }
                    })
                    .onTapGesture {
                        DeleteCollection = false
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
                        collectionVM.deleteCollection(id:getId)
                        if collectionVM.isDeleted {
                            withAnimation() {
                                DeleteCollection = false
                            }
                        }
                    },
                    button1Role: .cancel,
                    button2Role: .destructive
                )
            }
            .background(ClearBackgroundView())
        })
        .environmentObject(homeVm)
    }
    
    private func createButttonFunc () {
        collectionVM.createCollection(title: CollectionName, description: CollectionDescriptione)
  
    }
}


#Preview {
    collectionView()
        .environmentObject(HomeViewModel())
}

