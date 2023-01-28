//
//  GeneralView.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/26/23.
//

import SwiftUI

struct GeneralView: View {
    @AppStorage("fontSize") private var fontSize = 12.0
    
    var body: some View {
        VStack {
            Slider(value: $fontSize, in: 9...24) {
                Text("Font Size (\(fontSize, specifier: "%.0f") pts)")
            }
        }
    }
}
