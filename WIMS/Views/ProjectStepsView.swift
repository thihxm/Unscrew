//
//  ProjectStepsView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI
import CoreData

struct ProjectStepsView: View {
    @StateObject var stepData = StepViewModel()
    
    let project: Project
    var projectsSteps: [Step] {
        if let steps = project.steps as? Set<Step> {
            return Array(steps)
        }
        return [Step]()
    }
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "arrow.up.arrow.down")
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
            .padding(.horizontal, 24)
            .buttonStyle(PlainButtonStyle())
            .font(.title2)
            
            ScrollView(.vertical) {
                VStack {
                    ForEach(projectsSteps, id: \.self) { step in
                        ProjectStepRow(stepData: stepData, step: step)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .padding(.top, 32)
        .background(Color.background.edgesIgnoringSafeArea(.all))
        .navigationTitle(project.name)
    }
}

struct ProjectStepsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStepsView(project: Project.example(context: PersistenceController.preview.container.viewContext))
    }
}
