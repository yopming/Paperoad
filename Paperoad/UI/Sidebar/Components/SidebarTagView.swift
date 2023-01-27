//
//  SidebarTagView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct SidebarTagView: View {
    @State private var isExpanded: Bool = true
    
    var body: some View {
        Section(header: Text("Tags")) {
            Label("Books", systemImage: "book.closed")
            Label("Tutorials", systemImage: "tv")
            Label("My Library", systemImage: "building.columns")
        }
    }
}
