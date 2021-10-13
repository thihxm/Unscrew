//
//  StepViewModel.swift
//  WIMS
//
//  Created by Thiago Medeiros on 08/10/21.
//

import Foundation
import CoreData
import UIKit
import Combine

class StepViewModel: ObservableObject {
    @Published var updateProject: Project!
    @Published var updateStep: Step!
    
    @Published var isDone: Bool = false
    @Published var name: String = ""
    @Published var notes: String = ""
    @Published var image: UIImage? = nil
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $updateStep
            .sink { [unowned self] step in
                self.isDone = step?.isDone ?? false
                self.name = step?.name ?? ""
                self.notes = step?.notes ?? ""
                self.image = step?.uiImage ?? nil
            }.store(in: &subscriptions)
    }
    
    func writeData(context: NSManagedObjectContext) {
        if updateStep != nil {
            updateStep?.isDone = isDone
            updateStep?.name = name
            updateStep?.notes = notes
            updateStep?.uiImage = image!
        } else {
            let step = Step(name: name, image: image, notes: notes, context: context)
            updateProject.addToSteps(step)
        }
        
        PersistenceController.shared.save()
    }
    
    func reset() {
        updateStep = nil
    }
    
    func editStep(project: Project, step: Step) {
        updateProject = project
        updateStep = step
    }
    
    func addStep(project: Project) {
        updateProject = project
    }
    
    func removeStep(project: Project, step: Step, context: NSManagedObjectContext) {
        print("step removed")
        project.removeFromSteps(step)
        Step.delete(step: step)
        
        reset()
        
        PersistenceController.shared.save()
    }
}
