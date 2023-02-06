//
//  GroupListViewModel.swift
//  Paperoad
//
//  Created by Tieming on 2/6/23.
//

import Combine
import Foundation

class GroupListViewModel: ObservableObject {
    @Published var groups = [Group]()
    
    private let database: AppDatabase
    private var groupsCancellable: AnyCancellable?
    
    init(database: AppDatabase) {
        print("INIT GROUP_LIST_VIEWMODEL")
        self.database = database
    }
    
    func bind() {
        print("BIND GROUP_LIST_VIEWMODEL")
        groupsCancellable = groupsPublisher(in: database).assign(to: \.groups, on: self)
    }
    
    func unbind() {
        print("UNBIND GROUP_LIST_VIEWMODEL")
        groupsCancellable?.cancel()
    }
    
    deinit {
        print("DEINIT GROUP_LIST_VIEWMODEL")
    }
    
    func deleteGroups(atOffsets offsets: IndexSet) {
        let groupIDs = offsets.compactMap { groups[$0].id }
        try! database.deleteGroups(ids: groupIDs)
    }
    
    // Returns a publisher of the groups in the list
    private func groupsPublisher(in database: AppDatabase) -> AnyPublisher<[Group], Never> {
        database.groupsOrderedByNamePublisher()
            .breakpointOnError()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
