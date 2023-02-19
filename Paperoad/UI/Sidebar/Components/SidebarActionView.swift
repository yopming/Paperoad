//
//  SidebarActionView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarActionView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var name: String = ""

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

    
    // MARK: - Add Button
    private var addNewButton: some View {
        Menu {
            Button(
                action: {
                    appState.showGroupAddSheet = true
                },
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
        
        .sheet(
            isPresented: $appState.showGroupAddSheet,
            content: {
                SidebarGroupAddView()
            }
        )
    }
    
    // MARK: - Setting Button
    private var settingButton: some View {
        Button (
            action: {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
            },
            label: {
                Image(systemName: "gear")
            }
        )
        .buttonStyle(.borderless)
        .frame(maxWidth: 30)
    }
}
