//
//  ProjectStepRow.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import SwiftUI

struct ProjectStepRow: View {
    var stepTitle: String
    var isDone: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(isDone ? .black : .white)
                .frame(width: 24, height: 24)
                .wimsShadow()
            
            HStack(spacing: 8) {
                // MARK: TODO change to step image
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.systemGray3))
                    .frame(width: 80, height: 80)
                
                Text(stepTitle)
                    .font(.title3)
                    .padding(.trailing, 8)
            }
            .background(Color(UIColor.systemBackground))
            .cornerRadius(8)
        }
        .frame(maxHeight: 80)
    }
}

struct ProjectStepRow_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStepRow(stepTitle: "Nome do passo super top em até 2 linhas", isDone: true)
        ProjectStepRow(stepTitle: "Nome do passo super top em até 2 linhas", isDone: false)
    }
}

