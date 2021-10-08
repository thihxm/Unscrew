//
//  HomeProjectsView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI

struct HomeProjectsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(fetchRequest: Project.fetch(), animation: .default)
    private var projects: FetchedResults<Project>
    
    @State var selectedStatuses: Set<Status> = []
    @State var searchText: String = ""
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(maximum: 160), spacing: 24), count: 2)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 32) {
                HStack {
                    Text("Unscrew")
                        .font(.largeTitle.bold())
                    
                    Spacer()
                    
                    Button(action: {
                        _ = Project.example(context: viewContext)
                        do {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 16)
                
                VStack(alignment: .center, spacing: 24) {
                    SearchBar(text: $searchText)
                    StatusSelector(selectedStatuses: $selectedStatuses)
                }
                .padding(.horizontal, 24)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(projects) { project in
                            NavigationLink(
                                destination: {
                                    ProjectStepsView(project: project)
                                },
                                label: {
                                    ProjectCard(project: project)
                                })
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 24)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Unscrew")
            .navigationBarHidden(true)
        }
    }
}

struct HomeProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeProjectsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
