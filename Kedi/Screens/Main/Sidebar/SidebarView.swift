//
//  SidebarView.swift
//  Kedi
//
//  Created by Saffet Emin Reisoğlu on 2/3/24.
//

import SwiftUI

struct SidebarView: View {
    
    @State private var selection: NavigationItem? = {
        (MeManager.shared.me == nil || MeManager.shared.projects == nil) ? .settings : .overview
    }()
    
    var body: some View {
        NavigationSplitView {
            List(NavigationItem.allCases, selection: $selection) { item in
                makeSideItem(item: item)
            }
            .navigationTitle("Kedi")
        } detail: {
            NavigationStack {
                switch selection {
                case .overview:
                    OverviewView()
                case .transactions:
                    TransactionsView()
                case .notifications:
                    NotificationsView()
                        .environmentObject(PushNotificationsManager.shared)
                case .settings:
                    SettingsView()
                        .environmentObject(PurchaseManager.shared)
                        .environmentObject(PushNotificationsManager.shared)
                case .none:
                    Text("")
                }
            }
        }
    }
    
    private func makeSideItem(
        item: NavigationItem
    ) -> some View {
        NavigationLink(value: item) {
            Label(item.title, systemImage: item.icon)
                .symbolVariant(item == selection ? .fill : .none)
        }
    }
}

#Preview {
    SidebarView()
}
