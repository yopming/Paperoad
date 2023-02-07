//
//  SidebarGroupView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarGroupView: View {
    @Environment(\.appDatabase) private var appDatabase
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    var groups: [Group]
    @State private var selectedGroup: Group?
    
    var body: some View {
        List {
            Section(header: Text("Groups")) {
                ForEach(groups) { group in
                    NavigationLink(destination: MainView(par: group.name)) {
                        Label(group.name, systemImage: "folder")
                    }
                    .contextMenu {
                        Button("Rename Group") {
                            selectedGroup = group
                        }
                        
                        Button("Delete") {
                            trash(id: group.id)
                            // TODO delete the field "group" in papers
                        }
                    }
                }
            }
            
            Divider()
            
            NavigationLink(destination: MainView(par: "Unfiled")) {
                Label("Unfiled", systemImage: "square.stack")
            }
            
            NavigationLink(destination: MainView(par: "Trash")) {
                Label("Trash", systemImage: "trash")
            }
        }
            
        .sheet (item: $selectedGroup) { group in
            SidebarGroupEditView(
                groupName: group.name,
                group: group
            )
        }
    }
    
    private func trash(id: Int64?) {
        if id! > 0 {
            do {
                var ids = [Int64]()
                ids.append(id!)
                try appDatabase.deleteGroups(ids: ids)
            } catch {
                errorAlertIsPresented = true
                errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Trash Group error occurred"
            }
        }
    }
}
