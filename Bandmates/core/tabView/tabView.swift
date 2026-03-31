//
//  tabView.swift
//  Bandmates
//
//  Created by Mac mini on 18/03/2026.
//

import SwiftUI
import StoreKit

enum AppTab: Int, CaseIterable {
    case home, collection, charts, profile
 
    var title: String {
        switch self {
        case .home:       return "Home"
        case .collection: return "Collection"
        case .charts:     return "Charts"
        case .profile:    return "Profile"
        }
    }
 
    var icon: String {
        switch self {
        case .home:       return "house.fill"
        case .collection: return "square.grid.2x2.fill"
        case .charts:     return "chart.bar.fill"
        case .profile:    return "person.fill"
        }
    }
}
struct tabView: View {
    @StateObject private var Nvm = NotificationViewModel()
    @State private var selectedTab: AppTab = .home
    @State private var showMenu = false
    @State private var showShareSheet = false
    @State private var showNotifications = false
    @State private var notiCount : Int? = nil
    @Environment(\.requestReview) private var requestReview
    @Environment(\.dismiss) var dismiss
    let appID = "YOUR_APP_ID"
    
    var appStoreURL: URL {
        URL(string: "https://apps.apple.com/app/id\(appID)")!
    }
    var body: some View {
        ZStack {

            VStack(spacing: 0) {
                ZStack {
                    switch selectedTab {
                    case .home:       homwView().environmentObject(HomeViewModel())
                    case .collection: collectionView().environmentObject(HomeViewModel())
                    case .charts:     chartView().environmentObject(HomeViewModel())
                    case .profile:    profileView().environmentObject(HomeViewModel())
                    }
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .opacity(0.2)
                
                // Custom Tab Bar
                CustomTabBar(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(edges: .bottom)
            .toolbar {
                ToolbarItem(placement:.topBarLeading) {
                    toolBarMenuButton(action: {
                        withAnimation() {
                            showMenu.toggle()
                        }
                        print("tool bar menu button")
                    })
                }.sharedBackgroundVisibility(.hidden)
                ToolbarItem {
                    Text(toolBarText())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.background)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.sharedBackgroundVisibility(.hidden)
                if selectedTab == .home {
                    ToolbarItem {
                        homeViewNotificationButton(action: {
                            showNotifications.toggle()
                        }, notificationCount: Nvm.UnReadNotifications?.count)
                        
                    }.sharedBackgroundVisibility(.hidden)
                }
            }
            if showMenu {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation() {
                            showMenu = false
                        }
                    }
                MenuView(
                    showMenu: $showMenu,
                    homeButtonAction: {selectedTab = .home},
                    ratingButtonAction: {
                        requestReview()
                        
                    },
                    shareButtonAction: {
                        withAnimation(.spring(.bouncy(duration: 0.5, extraBounce: 2.0))){
                            showShareSheet = true
                        }
                    },
                    logoutButtonAction: { dismiss() }
                ).frame(maxWidth: .infinity,alignment: .leading)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                   
                    
            }
        
        }.sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [appStoreURL])
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showNotifications) {
            NotifiCationsView()
                .environmentObject(Nvm)
        }
    }
        
    private func toolBarText() -> String {
        if selectedTab == .home {
            return "Bandmates"
        } else if selectedTab == .charts {
            return "Chart"
        } else if selectedTab == .profile {
                return "Profile"
            } else if selectedTab == .collection {
                return "Collection"
            }
        return "Bandmates"
    }
}
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
#Preview {
    tabView()
        .environmentObject(HomeViewModel())
}
