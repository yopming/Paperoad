//
//  SidebarView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarView: View {
    @State private var isExpanded: Bool = true
    
    var body: some View {
        List {
            DisclosureGroup(isExpanded: $isExpanded) {
                Label("Books", systemImage: "book.closed")
                Label("Tutorials", systemImage: "tv")
            } label: {
                Label("All", systemImage: "list.bullet.rectangle")
            }
        }
        .listStyle(SidebarListStyle())
        .toolbar {
            Button(action: toggleSidebar, label: {
                Label("Toggle Sidebar", systemImage: "sidebar.left")
            })
        }
        .frame(minWidth:200, maxWidth: 500)
    }
}

// function as action to toggle sidebar
private func toggleSidebar() {
    NSApp.keyWindow?.contentViewController?.tryToPerform(
        #selector(NSSplitViewController.toggleSidebar(_:)), with: nil
    )
}
