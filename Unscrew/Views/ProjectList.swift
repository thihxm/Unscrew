//
//  ProjectList.swift
//  Unscrew
//
//  Created by Thiago Medeiros on 08/10/21.
//

import SwiftUI

struct ProjectList: View {
    var fetchRequest: FetchRequest<Project>
    var projects: FetchedResults<Project> { fetchRequest.wrappedValue }
    @Binding var showProject: String?
    
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(maximum: 160), spacing: 24), count: 2)
    
    init(filter: String, selectedStatuses: Set<Status>, showProject: Binding<String?>) {
        let namePredicate = !filter.isEmpty ?
        NSPredicate(format: "name_ CONTAINS[cd] %@", filter) :
        NSPredicate(format: "TRUEPREDICATE")
        
        let statusPredicate = (selectedStatuses.isSuperset(of: [.done, .open]) ||
                                selectedStatuses.isEmpty) ?
        NSPredicate(format: "TRUEPREDICATE") :
        NSPredicate(format: "isDone == %@", NSNumber(value: selectedStatuses.contains(.done)))
        
        self.fetchRequest = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [], predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [namePredicate, statusPredicate]))
        self._showProject = showProject
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(projects) { project in
                    NavigationLink(
                        destination: ProjectStepsView(project: project),
                        tag: project.name,
                        selection: $showProject
                    ) {
                        ProjectCard(project: project)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 24)
        }
    }
}

struct ProjectList_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList(filter: "", selectedStatuses: Set<Status>(), showProject: .constant(nil))
    }
}
