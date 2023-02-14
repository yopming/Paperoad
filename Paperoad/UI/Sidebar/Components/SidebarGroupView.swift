//
//  SidebarGroupView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI
import GRDBQuery

struct SidebarGroupView: View {
    @Environment(\.appDatabase) private var appDatabase
    
    @Query(GroupCountRequest(), in: \.appDatabase) private var groupCounts: [GroupCount]
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    var groups: [Group]
    @State private var selectedGroup: Group?
    
    var body: some View {
        List {
            Section(header: Text("Groups")) {
                ForEach(groups) { group in
                    NavigationLink(destination: PapersWrapperView(groupName: group.name, groupId: group.id ?? 0)) {
                        groupLabel(group: group)
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
            
            // TODO: Group name cannot be any of the followings
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
        }
            
        .sheet (item: $selectedGroup) { group in
            SidebarGroupEditView(
                groupName: group.name,
                group: group
            )
        }
        
    }
    
    
    func groupLabel(group: Group) -> some View {
        let count = getGroupCountById(group.id!)
        return HStack(spacing: 0) {
            Label(group.name, systemImage: "folder")
            if count > 0 {
                Spacer()
                Text("\(count)")
                    .foregroundColor(.gray.opacity(0.4))
            }
        }
    }
    
    private func getGroupCountById(_ groupId: Int64) -> Int {
        if let item = groupCounts.first(where: {$0.group == groupId}) {
            return item.count ?? 0
        } else {
            return 0
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
