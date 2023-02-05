//
//  SettingsView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, storage
    }
    
    var body: some View {
        TabView {
            GeneralView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            StorageView()
                .tabItem {
                    Label("Storage", systemImage: "internaldrive")
                }
                .tag(Tabs.storage)
        }
        .padding(35)
        .frame(width: 500)
        .frame(maxHeight: .infinity)
    }
}
