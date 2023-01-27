//
//  SidebarActionView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarActionView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Divider()
            Menu {
                Button("Add new group", action: {})
                Button("Add new tag", action: {})
            } label: {
                Label("Add", systemImage: "plus.app")
            }
            .menuStyle(BorderlessButtonMenuStyle())
        }
        .padding()
    }
}
