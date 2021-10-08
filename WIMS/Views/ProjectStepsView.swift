//
//  ProjectStepsView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI
import CoreData

struct ProjectStepsView: View {
    let project: Project
    @State var selectedStep: Step? = nil
    @State var presentDetails: Bool = false
    
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
                    ForEach(Array(project.steps! as Set), id: \.self) { step in
                        Button(action: {
                            selectedStep = (step as! Step)
                            presentDetails.toggle()
                        }) {
                            ProjectStepRow(step: step as! Step)
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .sheet(isPresented: $presentDetails) {
            StepSheetView(step: selectedStep!)
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
