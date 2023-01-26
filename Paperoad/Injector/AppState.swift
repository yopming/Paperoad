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
struct ViewState {
    var entitiesCount = StateWrapper(0)
    var entitiesViewSwitcher = StateWrapper(0)
    var entitiesViewSortSwitcher = StateWrapper(nil as String?)
    
    var isEditViewShown = StateWrapper(false)
    var isTagViewShown = StateWrapper(false)
    var isFolderViewShown = StateWrapper(false)
    var isNoteViewShown = StateWrapper(false)
    
    var alertInformation = StateWrapper(nil as String?)
    
    var processingQueueCount = StateWrapper(0)
    var realReinited = StateWrapper(nil as Date?)
    
    var searchMode = StateWrapper(SearchMode.general)
}

// MARK: - SharedData
struct SharedData {
    var searchQuery = StateWrapper(nil as String?)
    var editEntity = StateWrapper(PaperEntity())
}

struct SharedState {
    var selection = SelectionState()
    var viewState = ViewState()
    var sharedData = SharedData()
}
