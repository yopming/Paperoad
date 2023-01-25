//
//  SettingView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

struct SettingView: View {
    // Setting tab tag
    private enum Tabs: Hashable {
        case general
        case metadata
        case sync
        case export
    }
    
    var body: some View {
        TabView {
            GeneralPage()
                .frame(minHeight: 180)
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            ScrapperPage()
                .frame(minWidth: 300)
                .tabItem {
                    Label("Metadata", systemImage: "doc.text.magnifyingglass")
                }
                .tag(Tabs.metadata)
            CloudPage()
                .frame(minWidth: 100)
                .tabItem {
                    Label("Cloud", systemImage: "icloud.and.arrow.up")
                }
                .tag(Tabs.sync)
            ExportPage()
                .frame(minWidth: 300)
                .tabItem {
                    Label("Export", systemImage: "square.and.arrow.up")
                }
                .tag(Tabs.export)
        }
        .padding()
        .frame(width: 550)
    }
}
