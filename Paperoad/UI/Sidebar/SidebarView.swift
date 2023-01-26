//
//  SidebarView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            Label("Books", systemImage: "book.closed")
            Label("Tutorials", systemImage: "list.bullet.rectangle")
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
