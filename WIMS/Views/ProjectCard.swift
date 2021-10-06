//
//  ProjectCard.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import SwiftUI

struct ProjectCard: View {
    var projectTitle: String
    var done: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            // MARK: TODO change to project image
            RoundedRectangle(cornerRadius: 4)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Nome do aparelho em até 2 linhas")
                HStack {
                    Circle()
                        .fill(done ? .black : .white)
                        .frame(width: 8, height: 8)
                        .if(!done) {
                            $0.wimsInnerShadow()
                        }

                    if done {
                        Text("Pronto")
                    } else {
                        Text("Aberto")
                    }  
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: 160, maxHeight: 172)
        .padding(8)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .wimsShadow()
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCard(projectTitle: "Nome do aparelho em até 2 linhas", done: true)
        ProjectCard(projectTitle: "Nome do aparelho em até 2 linhas", done: false)
    }
}
