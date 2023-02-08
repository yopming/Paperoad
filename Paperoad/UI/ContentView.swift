//
//  ContentView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            SidebarView()
            PapersWrapperView(group: "initial")
                .toolbar {
                    ToolbarMiddle()
                }
        }
        .navigationViewStyle(.columns)
        
        .searchable(text: $searchText)
    }
}

// function as action to toggle sidebar
private func toggleSidebar() {
    NSApp.keyWindow?.contentViewController?.tryToPerform(
        #selector(NSSplitViewController.toggleSidebar(_:)), with: nil
    )
}

