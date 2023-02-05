//
//  StorageView.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/4/23.
//

import SwiftUI

struct StorageView: View {
    @AppStorage("prefStorage") private var storageDir = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text("Storage Folder")
            Text("Cloud sync folder can be chosen to enable synchronization.")
                .font(.footnote)
                .padding([.top], 3)
                .padding([.bottom], 10)
            HStack (alignment: .top) {
                TextEditor(text: .constant(storageDir))
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.secondary).opacity(0.5))
                Button("Change") {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = true
                    panel.canCreateDirectories = true
                    panel.canChooseFiles = false
                    if panel.runModal() == .OK {
                        self.storageDir = panel.url?.absoluteString ?? "<none>"
                    }
                }
            }
            .padding()
        }
    }
}
