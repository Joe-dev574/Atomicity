//
//  ObjectivesListView.swift
//  Atomicity
//
//  Created by Joseph DeWeese on 10/8/24.
//

import SwiftUI
import SwiftData

struct ObjectivesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var objectives: [Objective]
    @State var width = UIScreen.main.bounds.width
    init(sortOrder: SortOrder, filterString: String) {
        let sortDescriptors: [SortDescriptor<Objective>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Objective.status), SortDescriptor(\Objective.title)]
        case .title:
            [SortDescriptor(\Objective.title)]
        case .briefDescription:
            [SortDescriptor(\Objective.briefDescription)]
        }
        let predicate = #Predicate<Objective> { objective in
            objective.title.localizedStandardContains(filterString)
            || objective.briefDescription.localizedStandardContains(filterString)
            || filterString.isEmpty
        }
        _objectives = Query(filter: predicate, sort: sortDescriptors)
    }
    var body: some View {
        ScrollView{
            ForEach(objectives) { objective in
                NavigationLink{
                    EditObjectiveScreen(objective: objective)
                } label: {
                    ObjectiveCardView(objective: objective)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(objectives[index])
            }
        }
    }
}
