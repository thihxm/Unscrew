//
//  StepSheetView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI

struct StepSheetView: View {
    let step: Step
    
    @State var stepName: String
    @State var isDone: Bool = false
    @State var notes: String
    
    init(step: Step) {
        self.step = step
        self.stepName = step.name
        self.isDone = step.isDone
        self.notes = step.notes
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // MARK: TODO use step image
                Rectangle()
                    .fill(Color(UIColor.systemGray3))
                .frame(maxHeight: 231)
                
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .frame(width: 24, height: 24)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "chevron.right")
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.horizontal, 16)
                .font(.title2)
                .foregroundColor(.black)
                .wimsShadow()
            }
            
            VStack {
                Text(stepName)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Toggle(isOn: $isDone) {
                    Text("Concluído")
                }
                
                TextEditor(text: $notes)
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            .background(Color.white)
            .clipShape(RoundedCorners(corners: [.topLeft, .topRight], radius: 16))
            .offset(y: -16)
        }
        .navigationBarHidden(true)
        .background(Color.white)
    }
}

struct StepSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StepSheetView(step: Step.example(context: PersistenceController.preview.container.viewContext))
    }
}
