//
//  ContextMenuAddGroup.swift
//  Paperoad
//
//  Created by Tieming on 2/10/23.
//

import SwiftUI
import GRDBQuery

/// This context menu only shows in unfiled and each grop, not in "All papers" and "Trashed Papers".
/// Since the selected paper in "All papers" and "Trashed papers" may be from different group.
/// This cause inconsistent check in this context menu.
/// Right now, only show when selectedPapers.size == 1, and one paper should have only one group.
struct PapersContextMenuAddGroup: View {
    @Environment(\.appDatabase) private var appDatabase
    
    @Query(GroupRequest(), in: \.appDatabase) private var groups: [Group]
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    @State var paper: Paper
    
    var body: some View {
        Menu("Move to Group") {
            ForEach(groups) { group in
                if paper.group == group.id {
                    Button("\(group.name)") {}
                        .disabled(true)
                } else {
                    Button("\(group.name)") {
                        save(groupId: group.id ?? 0)
                    }
                }
            }
        }
    }
    
    private func save(groupId: Int64) {
        do {
            paper.group = groupId
            try appDatabase.savePaper(&paper)
        } catch {
            errorAlertIsPresented = true
            errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Add to Group Error occurred"
        }
    }
}
