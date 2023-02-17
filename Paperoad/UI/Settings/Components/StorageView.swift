//
//  StorageView.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/4/23.
//

import SwiftUI

struct StorageView: View {
    @Default(\.storageDir) var storageDir
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
                    let panel = NSOpenPanel()
                    panel.showsResizeIndicator = false
                    panel.showsHiddenFiles = false
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = true
                    panel.canCreateDirectories = true
                    panel.canChooseFiles = false
                    panel.begin { response in
                        guard response == .OK, let url = panel.url else { return }
                        
                        storageDirUrl = url.path(percentEncoded: true)
                        
                        do {
                            try handleURLReceivedFromOpenPanel(url)
                        } catch {
                            print("handleReceivedFromOpenPanel(): \(error)")
                        }
                    }
                }
            }
        }
    }
    
    private func handleURLReceivedFromOpenPanel(_ url: URL) throws -> Void {
        let data = try url.bookmarkData(
            options: .withSecurityScope,
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )
        
        let _ = url.startAccessingSecurityScopedResource()
        defer { url.stopAccessingSecurityScopedResource() }
        storageDir = data
    }
}

