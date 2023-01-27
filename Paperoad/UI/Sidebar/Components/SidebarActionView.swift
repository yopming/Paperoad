//
//  SidebarActionView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarActionView: View {
    var body: some View {
//        VStack {
//            Text("Paperoad")
//        }
//        .toolbar {
//            ToolbarItem(placement: .primaryAction){
//                Menu {
//                    Button("Add new group", action: {})
//                    Button("Add new tag", action: {})
//                } label: {
//                    Label("Star", systemImage: "plus.app")
//                }
//            }
//        }
//        .frame(height: 50)
//        .border(SeparatorShapeStyle(), width: 2)
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
//        .frame(height: 30)
        .padding()
    }
}
