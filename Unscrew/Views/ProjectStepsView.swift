//
//  ProjectStepsView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI
import CoreData

struct ProjectStepsView: View {
    private enum SortDirection {
        case asc, desc
    }
    
    @StateObject private var stepData = StepViewModel()
    
    let project: Project
    
    @State private var projectsSteps: [Step]
    @State private var showCreateStepSheet: Bool = false
    @State private var sortDirection: SortDirection = .asc
    
    init(project: Project) {
        self.project = project
        self.projectsSteps = {
            if let steps = project.steps as? Set<Step> {
                return Array(steps).sorted(by: { $0.timestamp < $1.timestamp })
            }
            return [Step]()
        }()
    }
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: sortSteps) {
                    Image(systemName: "arrow.up.arrow.down")
                }
                
                Spacer()
                
                Button(action: createStep) {
                    Image(systemName: "plus")
                }
            }
            .padding(.horizontal, 24)
            .buttonStyle(PlainButtonStyle())
            .font(.title2)
            
            ScrollView(.vertical) {
                VStack {
                    ForEach(projectsSteps, id: \.self) { step in
                        ProjectStepRow(stepData: stepData, project: project, step: step)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .padding(.top, 32)
        .background(Color.background.edgesIgnoringSafeArea(.all))
        .navigationTitle(project.name)
        .sheet(isPresented: $showCreateStepSheet) {
            StepSheetView(stepData: stepData)
        }
    }
    
    func sortSteps() {
        withAnimation {
            switch sortDirection {
            case .asc:
                projectsSteps = projectsSteps.sorted(by: { $0.timestamp > $1.timestamp })
                sortDirection = .desc
            case .desc:
                projectsSteps = projectsSteps.sorted(by: { $0.timestamp < $1.timestamp })
                sortDirection = .asc
            }
        }
    }
    
    func createStep() {
        stepData.addStep(project: project)
        showCreateStepSheet.toggle()
    }
}

struct ProjectStepsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStepsView(project: Project.example(context: PersistenceController.preview.container.viewContext))
    }
}
