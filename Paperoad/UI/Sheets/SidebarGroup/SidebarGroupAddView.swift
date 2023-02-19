//
//  SidebarGroupAddView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/28/23.
//

import SwiftUI

struct SidebarGroupAddView: View {
    @Environment(\.appDatabase) private var appDatabase
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var appState: AppState
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    @State private var groupName = ""
    
    var body: some View {
        VStack {
            Text("New Group")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            Form {
                TextField("Name:", text: $groupName)
                    .onSubmit {
                        appState.showGroupAddSheet = false
                        save(name: groupName)
                    }
            }
            
            Divider()
            
            HStack {
                Button("Close", role: .cancel) {
                    appState.showGroupAddSheet = false
                    dismiss()
                }
                Button("Create") {
                    appState.showGroupAddSheet = false
                    save(name: groupName)
                }
                .disabled(groupName.isEmpty)
                .buttonStyle(.borderedProminent)
                .tint(groupName.isEmpty ? .gray : .accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 350, alignment: .leading)
    }
    
    private func save(name: String) {
        do {
            var group = Group(name: name, createTime: Date(), updateTime: Date())
            try appDatabase.saveGroup(&group)
            dismiss()
        } catch {
            errorAlertIsPresented = true
            errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Error occurred"
        }
    }
}

