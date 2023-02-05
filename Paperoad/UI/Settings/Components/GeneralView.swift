//
//  GeneralView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct GeneralView: View {
    @AppStorage("prefFontSize") private var fontSize = 12.0
    @AppStorage("prefColorScheme") private var theme = "Follow System"
    
    let themes: [String] = AppConfig.Appearance.allCases.map { $0.rawValue }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 30) {
            Picker("Appearnace", selection: $theme) {
                ForEach(themes, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            
            Divider()
            
            Slider(value: $fontSize, in: 9...24) {
                Text("Font Size (\(fontSize, specifier: "%.0f") pts)")
            }
        }
        .padding()
    }
}
