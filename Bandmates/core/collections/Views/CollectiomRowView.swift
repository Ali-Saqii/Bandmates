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
    let ontapGesture: () -> Void
    @State private var showActionSheet = false
    var body: some View {
        ZStack(alignment:.trailing) {
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.background)
                    .frame(width: 3, height: 90)
                    
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
                        .lineLimit(2)
                }.frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal)
                    .overlay(content: {
                        Rectangle()
                            .fill(.textfieldcolor.opacity(0.1))
                    })
                    .onTapGesture {
                        ontapGesture()
                       showActionSheet = false
                       
                    }
                Image(systemName: "ellipsis")
                    .padding(20)
                    .onTapGesture {
                        showActionSheet.toggle()
                    }.background(
                        Circle()
                            .fill(.clear)
                    )
            }.frame(maxWidth: .infinity)
                .frame(height: 106)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .textfieldcolor, radius: 10)
            //            .padding(.horizontal)
            if showActionSheet {
                VStack(alignment:.leading) {
                    Text("Edit Collection")
                        .font(.dmSans(11, weight: .semiBold))
                        .padding(.all,2.5)
                        .onTapGesture {
                            editAction()
                        }
                    Text("Delete Collection")
                        .font(.dmSans(11, weight: .semiBold))
                        .padding(.all,2.5)
                        .onTapGesture {
                            DeleteActin()
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
    CollectiomRowView(Collection: DeveloperPreview.instance.collection,editAction: {print("edit")},DeleteActin: {print("delete")}, ontapGesture: {})
}
