//
//  chartView.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import SwiftUI

struct chartView: View {
    @StateObject var chVM = chartViewModel()
    @State private var selectedAlbum: AlbumRatingModel? = nil
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
           
                ScrollView {
                    VStack(){
                        if let Chart = chVM.chart {
                            ForEach(Chart) { chart in
                                VStack() {
                                    HStack {
                                        AsyncImage(url: URL(string:chart.image ?? "")) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 43, height: 43)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                
                                            } else if phase.error != nil {
                                                Image("placeholderImage")
                                                    .frame(width: 43, height: 43)
                                                    .clipShape(
                                                        RoundedRectangle(cornerRadius: 8)
                                                    ).background(
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .fill(
                                                                LinearGradient(colors: [Color.orange,Color.pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                                                            )
                                                            .strokeBorder(Color.background,lineWidth: 2)
                                                    )
                                                
                                            } else {
                                                ProgressView()
                                                    .frame(width: 43, height: 43)
                                            }
                                        }.padding(.leading,7)
                                        VStack(alignment:.leading,spacing:3) {
                                            Text(chart.albumName ?? "")
                                                .foregroundStyle(.black)
                                                .font(.dmSans(16, weight: .bold))
                                                .fontWeight(.semibold)
                                                .lineLimit(2)
                                            HStack(spacing:5) {
                                                Image("artist")
                                                    .tint(Color.background)
                                                Text(chart.albumArtist ?? "")
                                                    .font(.dmSans(13, weight: .medium))
                                                    .foregroundStyle(Color.background)
                                            }.frame(height: 16)
                                        }.frame(maxWidth: .infinity,alignment: .leading)
                                        
                                        if selectedAlbum?.id != chart.id {
                                            HStack(spacing: 5) {
                                                Image(systemName: "star.fill")
                                                    .foregroundStyle(.yellow)
                                                Text(chart.averageRating ?? "")
                                                    .font(.system(size: 18).bold())
                                                    .foregroundStyle(.black)
                                            }
                                        }
                                        
                                    }.frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.vertical)
                                        .overlay(content: {
                                            Rectangle()
                                                .fill(.textfieldcolor.opacity(0.01))
                                        })
                                        .padding(.horizontal)
                                        
                                        .onTapGesture {
                                            withAnimation() {
                                                selectedAlbum = (selectedAlbum?.id == chart.id) ? nil : chart
                                            }
                                        }
                                    if selectedAlbum?.id == chart.id {
                                        VStack {
                                            HStack(spacing:5) {
                                                Image(systemName: "star.fill")
                                                    .font(.title)
                                                    .foregroundStyle(.yellow)
                                                Text(chart.averageRating ?? "")
                                                    .font(.dmSans(28, weight: .semiBold))
                                                    .foregroundStyle(Color.black)
                                            }.frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.horizontal)
                                                .frame(height: 40)
                                            RatingChartView(ratings: chart.ratings)
                                        }
                                    }
                                    Divider()
                                }
                            }
                        }
                    }
                }.scrollIndicators(.hidden)
                .refreshable {
                     chVM.getChartData()
                }
                
            }
        }
    }

#Preview {
    chartView()
}
