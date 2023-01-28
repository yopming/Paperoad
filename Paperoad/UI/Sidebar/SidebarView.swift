//
//  SidebarView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarView: View {
    @State private var isExpanded: Bool = true
    
    var body: some View {
        List {
            SidebarGroupView()
            SidebarTagView()
        }
        // SidebarBottomView() at the very bottom
        .safeAreaInset(edge: .bottom) {
            SidebarActionView()
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth:100, idealWidth: 200)
    }
}
