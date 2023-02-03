//
//  GeneralView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct GeneralView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("generalFontSize") private var fontSize = 12.0
    
    @State private var selectedApperance = 0
    
    let appearanceTypes: [String] = AppConfig.Appearance.allCases.map { $0.rawValue }
    
    var body: some View {
        VStack (spacing: 30) {
//            Picker("Appearnace", selection: $selectedApperance) {
//                ForEach(0..<appearanceTypes.count, id: \.self) { index in
//                    Text(self.appearanceTypes[index])
//                }
//            }
//            .pickerStyle(RadioGroupPickerStyle())
//            .onAppear {
//            }
//            .onChange(of: selectedApperance) { value in
//            }
            
            Divider()
            
            Slider(value: $fontSize, in: 9...24) {
                Text("Font Size (\(fontSize, specifier: "%.0f") pts)")
            }
        }
        .padding()
    }
}
