//
//  SidebarActionView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarActionView: View {
    @State private var name: String = ""

    // which sheet to show
    @State private var showSheet: SidebarSheetView? = nil
    
    var body: some View {
        HStack(spacing: 10) {
            addNewButton
            Spacer()
            settingButton
        }
        .frame(height: 28, alignment: .leading)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 4)
        .overlay(alignment: .top) {
            Divider()
        }
    }
    
    @ViewBuilder
    func content(for mode: SidebarSheetView) -> some View {
        switch mode {
        case .group:
            SidebarGroupAddView(showSheet: $showSheet)
        case .tag:
            SidebarGroupAddView(showSheet: $showSheet)
        }
    }
    
    // MARK: - Add Button
    private var addNewButton: some View {
        Menu {
            Button(
                action: openNewGroupFormView,
                label: {
                    Label("New Group", systemImage: "plus")
                }
            )
        } label: {
            Image(systemName: "plus")
        }
        .menuStyle(.borderlessButton)
        .menuIndicator(.hidden)
        .frame(maxWidth: 30)
        
        .sheet(item: $showSheet) { mode in
            content(for: mode)
        }
    }
    
    // MARK: - Setting Button
    private var settingButton: some View {
        Button (
            action: {
                NSApp.sendAction(
                    Selector(("showSettingsWindow:")), to: nil, from: nil
                )
            },
            label: {
                Image(systemName: "gear")
            }
        )
        .buttonStyle(.borderless)
        .frame(maxWidth: 30)
    }
}


// MARK: - Actions
extension SidebarActionView {
    func openNewGroupFormView() {
        showSheet = .group
    }
}
