//
//  ProjectCard.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import SwiftUI

struct ProjectCard: View {
    var projectTitle: String
    var isDone: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            // MARK: TODO change to project image
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(UIColor.systemGray3))
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Nome do aparelho em até 2 linhas")
                HStack {
                    Circle()
                        .fill(isDone ? .black : .white)
                        .frame(width: 8, height: 8)
                        .if(!isDone) {
                            $0.wimsInnerShadow()
                        }

                    if isDone {
                        Text("Pronto")
                    } else {
                        Text("Aberto")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: 160, idealHeight: 172, maxHeight: 172)
        .padding(8)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .wimsShadow()
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCard(projectTitle: "Nome do aparelho em até 2 linhas", isDone: true)
        ProjectCard(projectTitle: "Nome do aparelho em até 2 linhas", isDone: false)
    }
}
