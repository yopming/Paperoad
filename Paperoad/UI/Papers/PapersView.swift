//
//  PapersView.swift
//  Paperoad
//
//  Created by Tieming on 1/27/23.
//

import SwiftUI

struct Person: Identifiable {
    let firstName: String
    let lastName: String
    let id = UUID()
}

private var people = [
    Person(firstName: "Homer", lastName: "Simpson"),
    Person(firstName: "Lisa", lastName: "Simpson"),
    Person(firstName: "Krusty", lastName: "Clown"),
    Person(firstName: "Marge", lastName: "Simpson"),
    Person(firstName: "Chief", lastName: "Wiggum"),
    Person(firstName: "Itchy", lastName: "Scratchy")
]

struct PapersView: View {
    @State private var sortOrder = [KeyPathComparator(\Person.firstName)]
    @State private var selectedPeople = Set<Person.ID>()
    
    var body: some View {
        VStack {
            Table(people, selection: $selectedPeople, sortOrder: $sortOrder) {
                TableColumn("First Name", value: \.firstName)
                TableColumn("Last Name", value: \.lastName)
            }
            .onChange(of: sortOrder) {
                people.sort(using: $0)
            }
            
            Text("\(selectedPeople.count) people selected")
                .padding()
        }
    }
}
