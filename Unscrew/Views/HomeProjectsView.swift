//
//  HomeProjectsView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI

struct HomeProjectsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(fetchRequest: Project.fetch(), animation: .default)
//    private var projects: FetchedResults<Project>
    
    @State private var selectedStatuses: Set<Status> = []
    @State private var searchText: String = ""
    @State private var showProjectNameAlert: Bool = false
    @State private var projectName: String = ""
    @State private var showProject: String? = nil
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(maximum: 160), spacing: 24), count: 2)
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .leading, spacing: 32) {
                    HStack {
                        Text("Unscrew")
                            .font(.largeTitle.bold())
                        
                        Spacer()
                        
                        Button(action: toggleAlert) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .center, spacing: 24) {
                        SearchBar(text: $searchText, search: search)
                        StatusSelector(selectedStatuses: $selectedStatuses)
                    }
                    .padding(.horizontal, 24)
                    
                    ProjectList(filter: searchText, selectedStatuses: selectedStatuses, showProject: $showProject)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .navigationTitle("Unscrew")
                .navigationBarHidden(true)
            }
            if showProjectNameAlert {
                ProjectNameAlert(text: $projectName, onSubmit: addItem, onClose: toggleAlert)
                    .transition(.asymmetric(insertion: .scale(scale: 1.1).combined(with: .opacity), removal: .opacity).animation(.easeInOut(duration: 0.1)))
            }
        }
    }
    
    private func toggleAlert() {
        withAnimation {
            showProjectNameAlert.toggle()
        }
    }
    
    private func addItem() {
        toggleAlert()
        withAnimation {
            let project = Project(name: projectName, context: viewContext)
            PersistenceController.shared.save()
            self.showProject = project.name
        }
    }
    
    private func search() {
        
    }
}

struct HomeProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeProjectsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
