//
//  SettingsView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general
    }
    
    var body: some View {
        TabView {
            GeneralView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
    }
}
