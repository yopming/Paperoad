//
//  PaperAddByIdView.swift
//  Paperoad
//
//  Created by Tieming on 2/1/23.
//

import SwiftUI

struct PaperAddByIdView: View {
    @Environment(\.appDatabase) private var appDatabase
    
    @EnvironmentObject var appState: AppState
    
    @Default(\.storageDir) var storageDir
    
    @State var dragOver = false
    @State var uploadedFileName: String = ""
    
    // publication id types
    let idTypes: [String] = PaperIdTypes.allCases.map { $0.rawValue }
    
    @State private var identifier = ""
    @State private var selectedIdType = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("New Paper by ID")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("New paper will be shown in group 'Unfiled'.")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(0.75)
                .padding([.top], -15)
            
            Divider()
            
            Form {
                Picker("Identifier Type", selection: $selectedIdType) {
                    ForEach(0..<idTypes.count, id: \.self) { index in
                        Text(self.idTypes[index])
                    }
                }
                .fixedSize()
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Identifier", text: $identifier)
                
                uploadBox()
            }
            
            
            Divider()
            
            HStack {
                Button("Close", role: .cancel) {
                    appState.showPaperAddByIdentifierSheet = false
                }
                
                Button("Create") {
                    // TODO: add by identifier
                    appState.showPaperAddByIdentifierSheet = false
                }
                .disabled(identifier.isEmpty)
                .buttonStyle(.borderedProminent)
                .tint(identifier.isEmpty ? .gray : .accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 450, alignment: .leading)
    }
    
    @ViewBuilder
    func uploadBox() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            GroupBox() {
                Text("Drag PDF file here.")
                    .font(.footnote)
                    .frame(maxWidth: .infinity)
                    .frame(height: 65, alignment: .center)
                
            }
            .blur(radius: dragOver ? 0.2 : 0)
            .opacity(dragOver ? 1 : 0.5)
            .padding([.top], 15)
        
            .onDrop(of: [kUTTypePDF], isTargeted: $dragOver) { providers, location in
                for provider in providers {
                    provider.loadFileRepresentation(forTypeIdentifier: kUTTypePDF) { url, error in
                        guard error == nil else {
                            print(error ?? "error in uploading")
                            return
                        }
                        
                        guard let url = url else { return }
                        let oldFile = url.deletingPathExtension().lastPathComponent
                        let newFile = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
                        
                        guard let storageUrl = restoreFileAccess(with: storageDir) else { return }
                        defer { storageUrl.stopAccessingSecurityScopedResource()}
                        
                        if !(storageUrl.startAccessingSecurityScopedResource()) {
                            print("startAccessingSecurityScopedResource() error.")
                        }
                        
                        let newUrl = URL(filePath: newFile, relativeTo: storageUrl)
                        
                        try? FileManager.default.copyItem(at: url, to: newUrl)
                        uploadedFileName = newFile
                        
                        #if debug
                        print(newUrl.absoluteString)
                        #endif
                        
                        // TODO: save paper to database
                    }
                }
                
                return true
            }
            
            if uploadedFileName != "" {
                GroupBox() {
                    HStack {
                        Label("\(uploadedFileName)", systemImage: "doc.fill")
                        Spacer()
                        Button(action: deleteFile, label: {
                            Label("Remove", systemImage: "xmark")
                        })
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

extension PaperAddByIdView {
    func deleteFile() {
        guard let storageUrl = restoreFileAccess(with: storageDir) else { return }
       
        let _ = storageUrl.startAccessingSecurityScopedResource()
        let filePath = storageUrl.appending(path: uploadedFileName)
        print(filePath.absoluteString)
        do {
            if FileManager.default.fileExists(atPath: filePath.absoluteString) {
                try FileManager.default.removeItem(atPath: filePath.absoluteString)
            } else {
                print("File not exist.")
            }
        } catch {
            print("\(error)")
        }
        
        storageUrl.stopAccessingSecurityScopedResource()
    }
}
