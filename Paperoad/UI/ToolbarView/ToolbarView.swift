//
//  ToolbarView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

class ToolbarViewModel: ObservableObject {
    @Published var searchText: String = ""
}

struct ToolbarView: View {
    @StateObject private var viewState = ToolbarViewModel()
    
    var body: some View {
        Text(verbatim: "ToolbarView")
    }
}
