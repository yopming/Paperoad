//
//  ContentView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import Combine
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SidebarView()
                .frame(width: 200)
            
            Text("Use button to toggle sidebar.")
                .frame(minWidth: 500)
        }
    }
}
