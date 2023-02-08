//
//  ToolbarMiddle.swift
//  Paperoad
//
//  Created by Tieming on 2/8/23.
//

import SwiftUI

struct ToolbarMiddle: ToolbarContent {
    @State private var isPaperAddViewPresented: Bool = false
    @State private var isPaperAddByIdViewPresented: Bool = false
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button(action: openPaperAddView, label: {
                Label("Add Empty", systemImage: "plus")
                    .labelStyle(.titleAndIcon)
            })
            .sheet(
                isPresented: $isPaperAddViewPresented,
                content: {
                    PaperAddView(presented: $isPaperAddViewPresented)
                }
            )
        }

        ToolbarItem {
            Button(action: openPaperAddByIdView, label: {
                Label("Add by Identifier", systemImage: "wand.and.stars")
                    .labelStyle(.titleAndIcon)
            })
            .sheet(
                isPresented: $isPaperAddByIdViewPresented,
                content: {
                    PaperAddByIdView(presented: $isPaperAddByIdViewPresented)
                }
            )
        }
    }
}

extension ToolbarMiddle {
    func openPaperAddView() {
        isPaperAddViewPresented = true
    }
}

extension ToolbarMiddle {
    func openPaperAddByIdView() {
        isPaperAddByIdViewPresented = true
    }
}
