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
    @Published var updateStep: Step!
    
    @Published var isDone: Bool = false
    @Published var name: String = ""
    @Published var notes: String = ""
    @Published var image: UIImage? = nil
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $updateStep.sink { [unowned self] step in
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
            _ = Step(name: name, image: image?.jpegData(compressionQuality: 1), notes: notes, context: context)
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
         
    }
    
    func reset() {
        updateStep = nil
    }
    
    func editStep(step: Step) {
        updateStep = step
    }
    
}
