//
//  ProjectStepRow.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import SwiftUI
import CoreData

struct ProjectStepRow: View {
    let step: Step
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(step.isDone ? .black : .white)
                .frame(width: 24, height: 24)
                .wimsShadow()
            
            HStack(spacing: 8) {
                // MARK: TODO change to step image
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.systemGray3))
                    .frame(width: 80, height: 80)
                
                Text(step.name)
                    .font(.title3)
                    .padding(.trailing, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(8)
        }
        .frame(maxHeight: 80)
    }
}

struct ProjectStepRow_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStepRow(step: Step.example(context: PersistenceController.preview.container.viewContext))
    }
}

