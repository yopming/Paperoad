//
//  MainView.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import Combine
import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            // MARK: - Sidebar
            SidebarView()
                .frame(minWidth: 200, maxWidth: 400)
            
            // MARK: = Main List
            HStack(spacing: 0) {
                EntitiesView()
                
                DetailView()
            }
            .toolbar {
                ToolbarView()
            }
        }
    }
}
