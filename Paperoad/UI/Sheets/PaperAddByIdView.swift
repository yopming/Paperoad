//
//  PaperAddByIdView.swift
//  Paperoad
//
//  Created by Tieming on 2/1/23.
//

import SwiftUI

struct PaperAddByIdView: View {
    @Environment(\.managedObjectContext) internal var viewContext
    
    @State var isPaperAddViewByIdPresented: Bool
    
    // publication id types
    let idTypes: [String] = PublicationConfig.IdTypes.allCases.map { $0.rawValue }
    
    @State private var identifier = ""
    @State private var selectedIdType = 0
    
    var body: some View {
        VStack {
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
                
                TextField("Identifier", text: $identifier)
            }
            
            Divider()
            
            HStack {
                Button("Close", role: .cancel) { isPaperAddViewByIdPresented = false }
                Button("Create") {
                    isPaperAddViewByIdPresented = false
                }
                .disabled(identifier.isEmpty)
            }
            .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .frame(width: 450, alignment: .leading)
    }
}
