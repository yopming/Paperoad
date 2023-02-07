//
//  SidebarGroupView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarGroupView: View {
    @Environment(\.appDatabase) private var appDatabase
    
    var groups: [Group]
    
    @State private var isEditViewPresented: Bool = false
    
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
                            isEditViewPresented = true
                            selectedGroup = group
                        }
                        
                        Button("Delete") {
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
                // presented: $isEditViewPresented,
                groupName: group.name,
                group: group
            )
        }
        
    }
    
}
