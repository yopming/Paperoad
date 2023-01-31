//
//  SidebarGroupView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarGroupView: View {
    @Environment(\.managedObjectContext) internal var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Group.name, ascending: false)],
        animation: .default
    )
    
    internal var groups: FetchedResults<Group>
    
    var body: some View {
        Section(header: Text("Groups")) {
            ForEach(groups) { group in
                GroupItem(group: group)
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: addGroup) {
                    Label("Add Group", systemImage: "plus")
                }
            }
        }
        .contextMenu {
            Button(action: {}, label: {
                Label("Test", systemImage: "sidebar.left")
            })
            Button(action: {}, label: {
                Label("Test", systemImage: "sidebar.left")
            })
            Divider()
            Button(action: {}, label: {
                Label("Test", systemImage: "sidebar.left")
            })
        }
    }
}

struct GroupItem: View {
    let group: Group
    
    var body: some View {
        Label(group.name!, systemImage: "folder")
    }
}
