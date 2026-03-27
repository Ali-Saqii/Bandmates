//
//  CollectiomRowView.swift
//  Bandmates
//
//  Created by Mac mini on 27/03/2026.
//

import SwiftUI

struct CollectiomRowView: View {
    let Collection: CollectionModel
    let editAction: () -> Void
    let DeleteActin: () -> Void

    @State private var showActionSheet = false
    var body: some View {
        ZStack(alignment:.trailing) {
            HStack {
                VStack(alignment:.leading) {
                    Text(Collection.collectionTitle)
                        .foregroundStyle(.black)
                        .font(.dmSans(14, weight: .bold))
                    HStack {
                        Image("album")
                        Text("\(Collection.albums.count) Albums")
                            .foregroundStyle(Color.background)
                            .font(.dmSans(12, weight: .semiBold))
                    }
                    Text(Collection.collectionDescription)
                        .font(.dmSans(11.5, weight: .medium))
                        .foregroundStyle(.gray)
                }.frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal)
                    Image(systemName: "ellipsis")
                        .padding()
                        .onTapGesture {
                            showActionSheet.toggle()
                        }

            }.frame(maxWidth: .infinity)
                .frame(height: 106)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment:.leading,content: {
                    Rectangle()
                        .fill(Color.background)
                        .frame(width: 3, height: 85)
                })
                .shadow(color: .textfieldcolor, radius: 10)
            //            .padding(.horizontal)
            if showActionSheet {
                VStack(alignment:.leading) {
                    Text("Edit Collection")
                        .font(.dmSans(11, weight: .semiBold))
                        .padding(.all,2.5)
                        .onTapGesture {
                            
                        }
                    Text("Delete Collection")
                        .font(.dmSans(11, weight: .semiBold))
                        .padding(.all,2.5)
                        .onTapGesture {
                            
                        }
                }.padding(.all,5)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .textfieldcolor, radius: 10)
                    .offset(x:-15,y: 35)
            }
        
        }
    }
}

#Preview {
    CollectiomRowView(Collection: DeveloperPreview.instance.collection,editAction: {print("edit")},DeleteActin: {print("delete")})
}
