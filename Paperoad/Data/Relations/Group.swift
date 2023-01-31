//
//  Group.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import CoreData

//extension PersistentController {
//    // MARK: - Create
//    func groupCreate(_ groupName: String, _ groupDesc: String, completion: (Group) -> Void) {
//        let group = Group(context: viewContext)
//        group.name = groupName
//        group.desc = groupDesc
//        group.createTime = Date()
//        group.updateTime = Date()
//        completion(group)
//        saveContext()
//    }
//    
//    // MARK: - Fetch
//    func groupFetch(completion:(Result<[Group], Error>) -> Void) {
//        let fetchRequest = Group.fetchRequest()
//        do {
//            let groups = try viewContext.fetch(fetchRequest)
//            completion(.success(groups))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//    
//    // MARK: - Update
//    func groupUpdate(_ group: Group, newName: String, newDesc: String) {
//        group.name = newName
//        group.desc = newDesc
//        group.updateTime = Date()
//        saveContext()
//    }
//    
//    // MARK: - Delete
//    func deleteGroup(_ group: Group) {
//        viewContext.delete(group)
//        saveContext()
//    }
//    
//    func saveContext() {
//        do {
//            try viewContext.save()
//        } catch {
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//    }
//}
