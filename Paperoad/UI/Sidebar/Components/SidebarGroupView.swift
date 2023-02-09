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
                    NavigationLink(destination: PapersWrapperView(group: group.name)) {
                        Label(group.name + " , " + String(group.id ?? 0), systemImage: "folder")
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
            NavigationLink(destination: PapersWrapperView(group: ".all")) {
                Label("All Papers", systemImage: "tray.2.fill")
            }
            NavigationLink(destination: PapersWrapperView(group: ".unfiled")) {
                Label("Unfiled", systemImage: "square.stack")
            }
            NavigationLink(destination: PapersWrapperView(group: ".trash")) {
                Label("Trash", systemImage: "trash")
            }
            // for debug, display all papers with those in trash
            NavigationLink(destination: PapersWrapperView(group: ".allwithtrash")) {
                Label("All Papers /w Trash", systemImage: "trash")
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
