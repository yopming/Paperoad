//
//  SidebarGroupViewModel.swift
//  Paperoad
//
//  Created by Tieming on 1/30/23.
//

import SwiftUI
import CoreData

extension SidebarGroupView {
    func deleteGroups(offsets: IndexSet) {
        withAnimation {
            offsets.map{ groups[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
