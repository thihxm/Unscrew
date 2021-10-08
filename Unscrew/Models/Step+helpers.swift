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
    convenience init(name: String, image: UIImage?, notes: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name_ = name
        self.isDone = false
        self.image_ = image?.jpegData(compressionQuality: 1) ?? nil
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
    
    var uiImage: UIImage? {
        get {
            guard let image = image_ else {
                return nil
            }
            return UIImage(data: image)
        }
        set {
            image_ = newValue!.jpegData(compressionQuality: 1.0)
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
    
    var timestamp: Date {
        get {
            return timestamp_ ?? Date()
        }
        set {
            timestamp_ = newValue
        }
    }
    
    public override func awakeFromInsert() {
        setPrimitiveValue("", forKey: StepProperties.name)
        setPrimitiveValue(false, forKey: StepProperties.isDone)
        setPrimitiveValue("", forKey: StepProperties.notes)
        setPrimitiveValue(Date(), forKey: StepProperties.timestamp)
    }
    
    static func delete(at offset: IndexPath, for steps: [Step]) {
        if let first = steps.first, let viewContext = first.managedObjectContext {
            offset.map { steps[$0] }.forEach(viewContext.delete)
        }
    }
    
    static func fetch() -> NSFetchRequest<Step> {
        let request = NSFetchRequest<Step>(entityName: "Step")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Step.timestamp_, ascending: true)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        return request
    }
    
    static func example(context: NSManagedObjectContext) -> Step {
        return Step(name: "Primero passo", image: UIImage(systemName: "photo.fill"), notes: "Super obsevações que devem ser lembradas na hora de aplicar este passo", context: context)
    }
}

struct StepProperties {
    static let name = "name_"
    static let isDone = "isDone"
    static let image = "image_"
    static let notes = "notes_"
    static let timestamp = "timestamp_"
}
