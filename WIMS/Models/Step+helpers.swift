//
//  Step+helpers.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import Foundation
import CoreData
import UIKit

extension Step {
    convenience init(name: String, image: Data?, notes: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name_ = name
        self.isDone = false
        self.image_ = image
        self.notes_ = notes
    }
    
    var name: String {
        get {
            return name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
    
    var uiImage: UIImage {
        get {
            return UIImage(data: image_!)!
        }
        set {
            image_ = newValue.jpegData(compressionQuality: 1.0)
        }
    }
    
    var notes: String {
        get {
            return notes_ ?? ""
        }
        set {
            notes_ = newValue
        }
    }
    
    public override func awakeFromInsert() {
        setPrimitiveValue("", forKey: StepProperties.name)
        setPrimitiveValue(false, forKey: StepProperties.isDone)
        setPrimitiveValue("", forKey: StepProperties.notes)
    }
    
    static func delete(at offset: IndexPath, for steps: [Step]) {
        if let first = steps.first, let viewContext = first.managedObjectContext {
            offset.map { steps[$0] }.forEach(viewContext.delete)
        }
    }
    
    static func fetch() -> NSFetchRequest<Step> {
        let request = NSFetchRequest<Step>(entityName: "Step")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Step.name_, ascending: true)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        return request
    }
    
    static func example(context: NSManagedObjectContext) -> Step {
        return Step(name: "Primero passo", image: UIImage(systemName: "photo.fill")!.jpegData(compressionQuality: 1), notes: "Super obsevações que devem ser lembradas na hora de aplicar este passo", context: context)
    }
}

struct StepProperties {
    static let name = "name_"
    static let isDone = "isDone"
    static let image = "image_"
    static let notes = "notes_"
}
