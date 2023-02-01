//
//  ContentView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isAddEmptyPaperPresented: Bool = false
    @State private var isAddPaperByDOIPresented: Bool = false
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            SidebarView()
            MainView(par: "Initial")
        }
        .toolbar(content: {
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: openAddEmptyPaperView, label: {
                    Label("Add Empty", systemImage: "plus")
                        .labelStyle(.titleAndIcon)
                })
                .sheet(
                    isPresented: $isAddEmptyPaperPresented,
                    content: {
                        PaperAddView(isPresented: $isAddEmptyPaperPresented)
                    }
                )
                
                Button(action: {}, label: {
                    Label("Add by Identifier", systemImage: "wand.and.stars")
                        .labelStyle(.titleAndIcon)
                })
                
            }
        })
        .searchable(text: $searchText)
    }
}

// function as action to toggle sidebar
private func toggleSidebar() {
    NSApp.keyWindow?.contentViewController?.tryToPerform(
        #selector(NSSplitViewController.toggleSidebar(_:)), with: nil
    )
}

// MARK: - Actions
extension ContentView {
    func openAddEmptyPaperView() {
        isAddEmptyPaperPresented = true
    }
}
