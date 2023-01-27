//
//  MainView.swift
//  Paperoad
//
//  Created by Tieming on 1/27/23.
//

import SwiftUI

struct MainView: View {
    @AppStorage("fontSize") private var fontSize = 12
    
    var body: some View {
        Text("Use button to toggle sidebar.")
            .font(.system(size: CGFloat(fontSize)))
            .frame(minWidth: 500)
    }
}
