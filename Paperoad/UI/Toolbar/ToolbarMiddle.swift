//
//  ToolbarMiddle.swift
//  Paperoad
//
//  Created by Tieming on 2/8/23.
//

import SwiftUI

struct ToolbarMiddle: ToolbarContent {
    @EnvironmentObject var appState: AppState
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button(action: openPaperAddView, label: {
                Label("Add Empty", systemImage: "plus")
                    .labelStyle(.titleAndIcon)
            })
            .sheet(
                isPresented: $appState.showPaperAddSheet,
                content: {
                    PaperAddView()
                }
            )
        }

        ToolbarItem {
            Button(action: openPaperAddByIdView, label: {
                Label("Add by Identifier", systemImage: "wand.and.stars")
                    .labelStyle(.titleAndIcon)
            })
            .sheet(
                isPresented: $appState.showPaperAddByIdentifierSheet,
                content: {
                    PaperAddByIdView()
                }
            )
        }
    }
}

extension ToolbarMiddle {
    func openPaperAddView() {
        appState.showPaperAddSheet = true
    }
}

extension ToolbarMiddle {
    func openPaperAddByIdView() {
        appState.showPaperAddByIdentifierSheet = true
    }
}
