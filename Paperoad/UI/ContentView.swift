//
//  ContentView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("fontSize") private var fontSize = 12
    
    var body: some View {
        NavigationView {
            SidebarView()
                .frame(width: 200)
            
            Text("Use button to toggle sidebar.")
                .font(.system(size: CGFloat(fontSize)))
                .frame(minWidth: 500)
        }
    }
}
