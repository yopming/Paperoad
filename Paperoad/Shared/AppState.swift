//
//  AppState.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/18/23.
//

import Foundation

class AppState: ObservableObject {
    @Published var showGroupAddSheet = false
    @Published var showGroupEditSheet = false
    
    @Published var showPaperAddSheet = false
    @Published var showPaperAddByIdentifierSheet = false
    @Published var showPaperEditSheet = false
}
