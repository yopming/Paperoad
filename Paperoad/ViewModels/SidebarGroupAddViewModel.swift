//
//  SidebarGroupAddViewModel.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import SwiftUI
import CoreData

extension SidebarGroupAddView {
    func addGroup(name: String) {
        withAnimation {
            let newGroup = Group(context: viewContext)
            newGroup.name = name
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
