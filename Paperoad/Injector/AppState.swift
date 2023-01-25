//
//  AppState.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import SwiftUI
import Combine
import RealmSwift

// MARK: - SelectionState
struct SelectionState {
    var selectedCategorizer = StateWrapper(nil as String?)
    var selectedIds = StateWrapper(Set<ObjectId>.init())
}

// MARK: - ViewState


// MARK: - SharedData
struct SharedData {
    var searchQuery = StateWrapper(nil as String?)
    var editEntityDraft = StateWrapper()
}

struct SharedState {
    
}
