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
    
    private struct StepsList: View {
        @StateObject private var stepData = StepViewModel()
        
        let project: Project
        
        @FetchRequest var steps: FetchedResults<Step>
        
        init(project: Project, sortDirection: SortDirection) {
            self.project = project
            self._steps = FetchRequest(fetchRequest: Step.fetch(by: project, asc: sortDirection == .asc), animation: .default)
        }
        
        var body: some View {
            ScrollView(.vertical) {
                VStack {
                    ForEach(steps, id: \.self) { step in
                        ProjectStepRow(stepData: stepData, project: project, step: step)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
    @StateObject private var stepData = StepViewModel()
    
    let project: Project
    
    init(project: Project) {
        self.project = project
    }
    
    @State private var showCreateStepSheet: Bool = false
    @State private var sortDirection: SortDirection = .asc
    
    var body: some View {
        return VStack(spacing: 16) {
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
            
            StepsList(project: project, sortDirection: sortDirection)
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
                sortDirection = .desc
            case .desc:
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
        ProjectStepsView(
            project: Project.example(context: PersistenceController.preview.container.viewContext)
        )
    }
}
