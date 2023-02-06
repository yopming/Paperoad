//
//  ContentView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPaperAddViewPresented: Bool = false
    @State private var isPaperAddByIdViewPresented: Bool = false
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            SidebarView()
            MainView(par: "Initial")
        }
        .toolbar(content: {
            // TODO: - customizable toolbar
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: openPaperAddView, label: {
                    Label("Add Empty", systemImage: "plus")
                        .labelStyle(.titleAndIcon)
                })
                .sheet(
                    isPresented: $isPaperAddViewPresented,
                    content: {
                        PaperAddView(isPaperAddViewPresented: $isPaperAddViewPresented)
                    }
                )

                Button(action: openPaperAddByIdView, label: {
                    Label("Add by Identifier", systemImage: "wand.and.stars")
                        .labelStyle(.titleAndIcon)
                })
                .sheet(
                    isPresented: $isPaperAddByIdViewPresented,
                    content: {
                        PaperAddByIdView(isPaperAddViewByIdPresented: $isPaperAddByIdViewPresented)
                    }
                )
                
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
    func openPaperAddView() {
        isPaperAddViewPresented = true
    }
}

extension ContentView {
    func openPaperAddByIdView() {
        isPaperAddByIdViewPresented = true
    }
}
