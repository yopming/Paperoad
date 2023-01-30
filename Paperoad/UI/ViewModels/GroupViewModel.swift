//
//  GroupViewModel.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/30/23.
//

import Foundation
import Combine

class GroupViewModel: ObservableObject {
    @Published var groups = [Group]()
    
    private let database: AppDatabase
    private var groupsCancellable: AnyCancellable?
    
    init(database: AppDatabase) {
        print("INIT GROUP_VIEWMODEL")
        self.database = database
    }
    
    deinit {
        print("DEINIT GROUP_VIEWMODEL")
    }
    
    func bind() {
        print("BIND GROUP_VIEWMODEL")
        groupsCancellable = groupsPublisher(in: database).assign(to:  \.groups, on: self)
    }
    
    func unbind() {
        print("UNBIND GROUP_VIEWMODEL")
        groupsCancellable?.cancel()
    }
    
    // publisher
    private func groupsPublisher(in database: AppDatabase) -> AnyPublisher<[Group], Never> {
        database.groupsOrderedByTitlePublisher()
            .breakpointOnError()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
