//
//  TabBarView.swift
//  Kedi
//
//  Created by Saffet Emin Reisoğlu on 2/3/24.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selection: NavigationItem
    
    init() {
        selection = (MeManager.shared.me == nil || MeManager.shared.projects == nil) ? .settings : .overview
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationStack {
                OverviewView()
            }
            .tag(NavigationItem.overview)
            .tabItem {
                makeTabItem(item: .overview)
            }
            
            NavigationStack {
                TransactionsView()
            }
            .tag(NavigationItem.transactions)
            .tabItem {
                makeTabItem(item: .transactions)
            }
            
            NavigationStack {
                NotificationsView()
                    .environmentObject(PushNotificationsManager.shared)
            }
            .tag(NavigationItem.notifications)
            .tabItem {
                makeTabItem(item: .notifications)
            }
            
            NavigationStack {
                SettingsView()
                    .environmentObject(PurchaseManager.shared)
                    .environmentObject(PushNotificationsManager.shared)
            }
            .tag(NavigationItem.settings)
            .tabItem {
                makeTabItem(item: .settings)
            }
        }
    }
    
    private func makeTabItem(
        item: NavigationItem
    ) -> some View {
        Label(item.title, systemImage: item.icon)
            .symbolVariant(item == selection ? .fill : .none)
            .environment(\.symbolVariants, .none)
    }
}

#Preview {
    TabBarView()
}
