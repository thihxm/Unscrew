//
//  Project+helpers.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import Foundation
import CoreData
import UIKit

extension Project {
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name_ = name
        self.isDone = false
    }
    
    var name: String {
        get {
            return name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
    
    public override func awakeFromInsert() {
        setPrimitiveValue("", forKey: ProjectProperties.name)
        setPrimitiveValue(false, forKey: ProjectProperties.isDone)
    }
    
    func firstStepImage() -> UIImage? {
        let steps = Array(self.steps as! Set<Step>)
        return steps.first?.uiImage
    }
    
    static func delete(at offset: IndexPath, for projects: [Project]) {
        if let first = projects.first, let viewContext = first.managedObjectContext {
            offset.map { projects[$0] }.forEach(viewContext.delete)
        }
    }
    
    static func fetch() -> NSFetchRequest<Project> {
        let request = NSFetchRequest<Project>(entityName: "Project")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.name_, ascending: true)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        return request
    }
    
    static func example(context: NSManagedObjectContext) -> Project {
        let project = Project(name: "Projeto teste", context: context)
        project.addToSteps(Step.example(context: context))
        project.addToSteps(Step.example(context: context))
        project.addToSteps(Step.example(context: context))
        return project
    }
}

struct ProjectProperties {
    static let name = "name_"
    static let isDone = "isDone"
}
