//
//  SidebarUploadView.swift
//  Paperoad
//
//  Created by Tieming on 2/14/23.
//

import SwiftUI

struct SidebarUploadView: View {
    @Environment(\.appDatabase) private var appDatabase
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertMessage = ""
    
    @Default(\.storageDir) var storageDir
    
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
                    let oldFileName = url.deletingPathExtension().lastPathComponent
                    
                    // store the uploaded file to storageDir
                    let newFileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
                    
                    guard let storageUrl = restoreFileAccess(with: storageDir) else { return }
                    defer { storageUrl.stopAccessingSecurityScopedResource() }
                    
                    if !(storageUrl.startAccessingSecurityScopedResource()) {
                        print("startAccessingSecurityScopedResource() error.")
                    }
                    let newUrl = URL(filePath: newFileName, relativeTo: storageUrl)
                    try? FileManager.default.copyItem(at: url, to: newUrl)
                    
                    #if debug
                    print(newUrl.absoluteString)
                    #endif
                    
                    // save the paper to storageDir
                    savePaper(title: oldFileName, url: newUrl.absoluteString)
                }
            }
            
            return true
        }
    }
    
    private func savePaper(title: String, url: String) {
        do {
            var paper = Paper.newFile(title: title, attachment: url)
            try appDatabase.savePaper(&paper)
        } catch {
            errorAlertIsPresented = true
            errorAlertMessage = (error as? LocalizedError)?.errorDescription ?? "Paper add error occured."
        }
    }
}

