//
//  SaveAlbumPopover.swift
//  Bandmates
//
//  Created by Mac mini on 26/03/2026.
//

import SwiftUI

struct SaveAlbumPopover: View {
    @EnvironmentObject var hvm : HomeViewModel
    let collections: [CollectionModel]
    @State private var SelectedCollection: CollectionModel? = nil
    @Binding var showPopUp : Bool
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
                        ForEach(collections) { collection in
                            Divider()
                            HStack {
                                Text(collection.collectionTitle)
                                    .foregroundStyle(.black)
                                    .font(.dmSans(17, weight: .medium))
                                Spacer()
                                Circle()
                                    .stroke((SelectedCollection != nil) ? Color.background : .gray, lineWidth: 2.5)
                                    .frame(width: 20, height: 20)
                                    .overlay {
                                        Circle()
                                            .fill((SelectedCollection != nil) ? Color.background : .white)
                                            .frame(width: 10, height: 10)
                                            
                                    }
                            }.onTapGesture {
                                SelectedCollection = collection
                            }
                        
                        }
                    }.padding(.horizontal)
                }.scrollIndicators(.hidden)

                buttonView(action: {}, buttonText: "Save Album", height: 45)
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
    SaveAlbumPopover(collections: DeveloperPreview.instance.collections, showPopUp: .constant(false))
        .environmentObject(HomeViewModel())
}
