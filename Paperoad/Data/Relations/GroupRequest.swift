//
//  GroupRequest.swift
//  Paperoad
//
//  Created by Tieming on 2/5/23.
//

import Combine
import GRDB
import GRDBQuery

/// A request can be used with the `@Query` property wrapper in order to
/// feed a view with a list of groups.
///
/// struct MyView: View {
///     @Query(GroupRequest(ordering: .byName)) private var groups: [Group]
///     var body: some View {
///         List(groups) { group in
///             ...
///         }
///     }
/// }
struct GroupRequest: Queryable {
    enum Ordering {
        case byName
        case byCreateTime
    }
    
    // the ordering used by the group request
    var ordering: Ordering
    
    static var defaultValue: [Group] { [] }
    
    func publisher(in appDatabase: AppDatabase) -> AnyPublisher<[Group], Error> {
        ValueObservation
            .tracking(fetchValue(_:))
            .publisher(in: appDatabase.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
    
    func fetchValue(_ db: Database) throws -> [Group] {
        switch ordering {
        case .byName:
            return try Group.all().orderedByName().fetchAll(db)
        case .byCreateTime:
            return try Group.all().orderedByCreateTime().fetchAll(db)
        }
    }
}
