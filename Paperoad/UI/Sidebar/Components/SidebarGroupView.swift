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
        sortDescriptors: [NSSortDescriptor(keyPath: \Group.name, ascending: true)],
        animation: .default
    ) internal var groups: FetchedResults<Group>
    
    var body: some View {
        Section(header: Text("Groups")) {
            ForEach(groups) { group in
                NavigationLink(destination: MainView(par: group.name!)) {
                    Label(group.name!, systemImage: "folder")
                        .contextMenu {
                            Button(action: {
                                viewContext.delete(group)
                                do {
                                    try viewContext.save()
                                } catch {
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }, label: {
                                Label("Delete", systemImage: "sidebar.left")
                            })
                        }
                }
            }
            .onDelete(perform: deleteGroups)
        }
        
        Divider()
        
        NavigationLink(destination: MainView(par: "unfiled")) {
            Label("Unfiled", systemImage: "square.stack.fill")
        }
        
        NavigationLink(destination: MainView(par: "Trash")) {
            Label("Trash", systemImage: "trash.fill")
        }
    }
}
