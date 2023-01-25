//
//  SidebarView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

struct SidebarView: View {
    @AppStorage("showSidebarCount") private var showSidebarCount = true
    
    @State private var isProgressViewShown: Bool = false
    
    // Tags
    // @Binding var tags:
    @State private var tagExpanded: Bool = true
    
    // Folders
    @State private var folderExpanded: Bool = true
    
    var body: some View {
        List() {
            sectionTitle("Library")
            HStack {
                Label("All Papers", systemImage: "rectangle.stack")
                Spacer()
                if isProgressViewShown {
                    Spacer()
                    Text("      ")
                        .overlay {
                            ProgressView()
                                .scaleEffect(x: 0.5, y: 0.5, anchor: .center)
                        }
                }
            }
            .tag("lib-all")
            
            Label("Flags", systemImage: "flag")
                .tag("lib-flag")
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.status) {
                Button(
                    action: {
                        NSApp.keyWindow?.firstResponder?.tryToPerform(
                            #selector(NSSplitViewController.toggleSidebar(_:)), with: nil
                        )
                    },
                    label: {
                        Label("Toggle Sidebar", systemImage: "sidebar.left")
                    }
                )
            }
        }
        
        Spacer()
    }
    
//    private func TagContent() -> AnyView {
//    }
//    
//    private func FolderContent() -> AnyView {
//    }
}


private extension SidebarView {
    func sectionTitle(_ text: String) -> some View {
        return Text(text)
            .bold()
            .font(.subheadline)
            .foregroundColor(Color.secondary.opacity(0.8))
    }
}
