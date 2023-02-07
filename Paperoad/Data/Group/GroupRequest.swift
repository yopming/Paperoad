//
//  GroupRequest.swift
//  Paperoad
//
//  Created by Tieming on 2/6/23.
//

import GRDB
import GRDBQuery
import Combine

/// A group request can be used with `@Query` property wrapper for a view with a list of groups.
/// struct MyView: View {
///     @Query(GroupRequest()) private var groups: [Group]
///     var body: some View {
///         List(groups) { group in ...
///     }
/// }
struct GroupRequest: Queryable {
    static var defaultValue: [Group] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[Group], Error> {
        ValueObservation
            .tracking{ db in try Group.fetchAll(db) }
            .publisher(in: appDatabase.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
}
