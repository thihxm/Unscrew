//
//  ProjectList.swift
//  Unscrew
//
//  Created by Thiago Medeiros on 08/10/21.
//

import SwiftUI

struct ProjectList: View {
    @FetchRequest var projects: FetchedResults<Project>
//    @State var projects: FetchedResults<Project> { fetchRequest.wrappedValue }
    @Binding var showProject: String?
    
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(maximum: 160), spacing: 24), count: 2)

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

//struct ProjectList_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectList(projects: Fet, showProject: .constant(""))
//    }
//}
