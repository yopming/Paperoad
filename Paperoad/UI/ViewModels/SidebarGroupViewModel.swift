//
//  SidebarGroupViewModel.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import SwiftUI
import CoreData

extension SidebarGroupView {
    func addGroup() {
        withAnimation {
            let newGroup = Group(context: viewContext)
            newGroup.name = "test"
            newGroup.createTime = Date()
            newGroup.updateTime = Date()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
