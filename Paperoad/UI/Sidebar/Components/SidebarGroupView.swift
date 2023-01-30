//
//  SidebarGroupView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarGroupView: View {
    @State private var isExpanded: Bool = true
    
    @StateObject var viewModel: GroupViewModel
    
    var body: some View {
        Section(header: Text("Groups")) {
            ForEach(viewModel.groups) {group in
                GroupItem(group: group)
            }
            
            Label("Books", systemImage: "book.closed")
            Label("Tutorials", systemImage: "tv")
            Label("My Library", systemImage: "building.columns")
            
            ForEach(1..<10) {i in
                Label("label \(i)", systemImage: "sidebar.left")
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
        Label(group.name, systemImage: "folder")
    }
}
