//
//  ProjectStepsView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI

struct ProjectStepsView: View {
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Nome do projeto")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            VStack(spacing: 16) {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .font(.title2)
                
                ScrollView(.vertical) {
                    ForEach(0..<5) { _ in
                        ProjectStepRow(stepTitle: "Nome do passo super top em até 2 linhas", isDone: true)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .background(Color.background.edgesIgnoringSafeArea(.all))
    }
}

struct ProjectStepsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStepsView()
    }
}
