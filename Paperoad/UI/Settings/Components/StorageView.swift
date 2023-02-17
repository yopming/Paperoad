//
//  StorageView.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/4/23.
//

import SwiftUI

struct StorageView: View {
    @Default(\.storageDir) var storageDir
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text("Storage Folder")
            Text("Cloud sync folder can be chosen to enable synchronization.")
                .font(.footnote)
                .padding([.top], 3)
                .padding([.bottom], 10)
            HStack (alignment: .center) {
                Text(storageDir)
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
                        guard response == .OK,
                              let url = panel.url else { return }
                        self.storageDir = url.path(percentEncoded: true)
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
        
        self.$storageDir = url.path
    }
}

