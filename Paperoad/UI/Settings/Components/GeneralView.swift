//
//  GeneralView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct GeneralView: View {
    @AppStorage("prefColorScheme") private var theme = "Follow System"
    @AppStorage("prefPdfReader") private var pdfReader = "System"
    
    let themes: [String] = AppConfig.Appearance.allCases.map { $0.rawValue }
    let pdfReaders: [String] = AppConfig.PdfReader.allCases.map { $0.rawValue }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 30) {
            Text("Appearance")
            Text("")
            Picker("Appearnace", selection: $theme) {
                ForEach(themes, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Picker("PDF Reader", selection: $pdfReader) {
                ForEach(pdfReaders, id: \.self) {
                    Text($0)
                }
            }
        }
        .padding()
    }
}
