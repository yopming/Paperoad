//
//  PaperAddByIdView.swift
//  Paperoad
//
//  Created by Tieming on 2/1/23.
//

import SwiftUI

struct PaperAddByIdView: View {
    @Binding var presented: Bool
    
    // publication id types
    let idTypes: [String] = PaperConfig.IdTypes.allCases.map { $0.rawValue }
    
    @State private var identifier = ""
    @State private var selectedIdType = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("New Paper by ID")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
            }
            
            Text("New paper will be shown in group 'Unfiled'.")
            
            Divider()
            
            HStack {
                Button("Close", role: .cancel) { presented = false }
                Button("Create") { presented = false }
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
}
