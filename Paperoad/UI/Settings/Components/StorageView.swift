//
//  StorageView.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/4/23.
//

import SwiftUI

struct StorageView: View {
    @Default(\.storageDirUrl) var storageDirUrl
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text("Storage Folder")
            Text("Cloud sync folder can be chosen to enable synchronization.")
                .font(.footnote)
                .padding([.top], 3)
                .padding([.bottom], 10)
            HStack (alignment: .center) {
                Text(storageDirUrl)
                    .padding(6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.background)
                    .cornerRadius(4)
                Button("Change") {
                    if let url = selectFolderPanel() {
                        storageDirUrl = url.path(percentEncoded: true)
                        saveBookmarkData(for: url)
                    }
                }
            }
        }
    }
    
    fileprivate func selectFolderPanel() -> URL? {
        let panel = NSOpenPanel()
        panel.message = "Choose one empty directory."
        panel.prompt = "Choose"
        panel.showsResizeIndicator = true
        panel.showsHiddenFiles = false
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.canChooseFiles = false
        let response = panel.runModal()
        return response == .OK ? panel.url : nil
    }
}
