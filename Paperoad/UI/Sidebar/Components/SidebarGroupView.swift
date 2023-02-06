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
    
    var body: some View {
        Section(header: Text("Groups")) {
            ForEach(groups) { group in
                NavigationLink(destination: MainView(par: group.name)) {
                    Label(group.name, systemImage: "folder")
                        .contextMenu {
                            Button(action: {
                                
                            }, label: {
                                Label("Rename", systemImage: "")
                            })
                            Button(action: {
                            }, label: {
                                Label("Delete", systemImage: "sidebar.left")
                            })
                        }
                }
            }
        }
//        .onAppear(perform: viewModel.bind)
//        .onDisappear(perform: viewModel.unbind)
        
        Divider()
        
        NavigationLink(destination: MainView(par: "unfiled")) {
            Label("Unfiled", systemImage: "square.stack")
        }
        
        NavigationLink(destination: MainView(par: "Trash")) {
            Label("Trash", systemImage: "trash")
        }
    }
}
