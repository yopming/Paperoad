//
//  SidebarView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI
import GRDBQuery

struct SidebarView: View {
    @Environment(\.appDatabase) private var appDatabase
    
    @Query(GroupRequest(), in: \.appDatabase) private var groups: [Group]
    
    var body: some View {
        VStack {
            SidebarGroupView(groups: groups)
            
            // TODO: tag implementation
            // SidebarTagView()
        }
        .safeAreaInset(edge: .bottom) {
            SidebarUploadView()
        }
        .safeAreaInset(edge: .bottom) {
            // at the bottom
            SidebarActionView()
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth:100, idealWidth: 200)
    }
}


// enum for sheets in Sidebar
enum SidebarSheetView: Identifiable {
    var id: Self { self }
    case group, tag
}

enum SidebarGroupSheetView: Identifiable {
    var id: Self { self }
    case groupRename
}
