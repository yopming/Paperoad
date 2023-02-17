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
                    
                    let storageUrl = getStoredUrl()
                    _ = storageUrl?.startAccessingSecurityScopedResource()
                    let newUrl = storageUrl?.appendingPathExtension(fileName)
                    try? FileManager.default.copyItem(at: url, to: newUrl!)
                    print(newUrl)
                    storageUrl?.stopAccessingSecurityScopedResource()
                }
            }
            
            return true
        }
    }
    
    private func getStoredUrl() -> URL? {
        let data = storageDir
        guard data.count > 0 else {
            return FileStorage.documentDirectory
        }
        
        do {
            var isStale = false
            let newUrl = try URL(
                resolvingBookmarkData: data,
                options: .withSecurityScope,
                relativeTo: nil,
                bookmarkDataIsStale: &isStale
            )
            
            return newUrl
        } catch {
            print("Error resolving bookmark: \(error)")
            return nil
        }
    }
}

