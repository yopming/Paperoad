//
//  SidebarUploadView.swift
//  Paperoad
//
//  Created by Tieming on 2/14/23.
//

import SwiftUI

struct SidebarUploadView: View {
    @Default(\.storageDir) var storageDir
    
    @State var files = [URL]()
    @State var dragOver = false
    
    var body: some View {
        GroupBox() {
            Text("Drag Here to Upload")
                .font(.footnote)
                .frame(maxWidth: .infinity)
                .frame(height: 65, alignment: .center)
        }
        .blur(radius: dragOver ? 0.2 : 0)
        .opacity(dragOver ? 1 : 0.5)
        .padding()
        
        .onDrop(of: [kUTTypePDF], isTargeted: $dragOver) { providers, location in
            for provider in providers {
                provider.loadFileRepresentation(forTypeIdentifier: kUTTypePDF) { url, error in
                    guard error == nil else {
                        print(error ?? "nothing")
                        return
                    }
                    
                    guard let url = url else { return }
                    let fileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
                    
                    guard let storageUrl = restoreFileAccess(with: storageDir) else {
                        return
                    }
                    defer { storageUrl.stopAccessingSecurityScopedResource() }
                    
                    if !(storageUrl.startAccessingSecurityScopedResource()) {
                        print("startAccessingSecurityScopedResource() error.")
                    }
                    let newUrl = URL(filePath: fileName, relativeTo: storageUrl)
                    try? FileManager.default.copyItem(at: url, to: newUrl)
                    print(newUrl)
                }
            }
            
            return true
        }
    }
}

