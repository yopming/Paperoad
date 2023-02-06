//
//  SidebarView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            SidebarGroupView()
            
            // TODO: tag implementation
            // SidebarTagView()
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
