//
//  ProjectCard.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import SwiftUI
import CoreData

struct ProjectCard: View {
    var project: Project
    
    var body: some View {
        VStack(spacing: 4) {
            if let image = project.firstStepImage() {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 96)
                    .cornerRadius(4)
            } else {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(UIColor.systemGray3))
                    .frame(height: 96)
            }
            
            VStack(alignment: .leading) {
                Text(project.name)
                Spacer()
                HStack {
                    Circle()
                        .fill(project.isDone ? .black : .white)
                        .frame(width: 8, height: 8)
                        .if(!project.isDone) {
                            $0.wimsInnerShadow()
                        }

                    if project.isDone {
                        Text("Pronto")
                    } else {
                        Text("Aberto")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: 160, idealHeight: 172, maxHeight: 172, alignment: .top)
        .padding(8)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .wimsShadow()
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCard(project: Project.example(context: PersistenceController.preview.container.viewContext))
    }
}
