//
//  SaveAlbumPopover.swift
//  Bandmates
//
//  Created by Mac mini on 26/03/2026.
//

import SwiftUI

struct SaveAlbumPopover: View {
    @EnvironmentObject var hvm : HomeViewModel
    @State private var SelectedCollection: MapedCollection? = nil
    @Binding var showPopUp : Bool
    let albumId: String
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                HStack {
                    Text("Select Collection")
                        .foregroundStyle(.black)
                        .font(.dmSans(20, weight: .semiBold))
                    Spacer()
                        Image(systemName: "xmark")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            withAnimation() {
                                showPopUp.toggle()
                            }
                        }
                }.padding(.horizontal)
                    .padding(.top)
                Text("Choose one of your existing collections below. The album you’re saving will be added to the selected collection.")
                    .font(.dmSans(11, weight: .medium))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.trailing)
                    .padding(.horizontal)
                ScrollView{
                    VStack {
                        if !hvm.mapedCollection.isEmpty {
                            ForEach(hvm.mapedCollection) { collection in
                                Divider()
                                HStack {
                                    Text(collection.title)
                                        .foregroundStyle(.black)
                                        .font(.dmSans(17, weight: .medium))
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                    
                                    Circle()
                                        .stroke(SelectedCollection?.id == collection.id ? Color.background : .gray, lineWidth: 2.5)
                                        .frame(width: 20, height: 20)
                                        .overlay {
                                            Circle()
                                                .fill(SelectedCollection?.id == collection.id ? Color.background : .white)
                                                .frame(width: 10, height: 10)
                                        }
                                }.overlay(content: {
                                    Rectangle().fill(.textfieldcolor.opacity(0.1))
                                })
                                .onTapGesture {
                                    SelectedCollection = collection
                                }
                                
                            }
                        }else {
                            Text("You have no collection yet please add collection first !!!!")
                                .multilineTextAlignment(.center)
                                .font(.dmSans(14, weight: .medium))
                                .foregroundStyle(.red)
                        }
                    }.padding(.horizontal)
                }.scrollIndicators(.hidden)
                    .onChange(of: hvm.isAlbumSaved) { _, newValue in
                        if newValue {
                            showPopUp = false
                            hvm.isAlbumSaved = false
                        }
                    }
                buttonView(action: {hvm.saveAlbum(albumId: albumId, collectionId: SelectedCollection?.id ?? "")}, buttonText: "Save Album", height: 45)
                    .padding(.horizontal)
                    .padding(.bottom)
            }.frame(maxWidth: .infinity)
                .frame(height: geo.size.height * 0.6)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black.opacity(0.5), radius: 15)
                .padding(.horizontal)
                .frame(maxHeight: .infinity, alignment: .center) // ← centers vertically

        }
    
    }
}

#Preview {
    SaveAlbumPopover(showPopUp: .constant(false), albumId: "")
        .environmentObject(HomeViewModel())
}
