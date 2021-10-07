//
//  StepSheetView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI

struct StepSheetView: View {
    var stepName: String = "Nome do passo"
    
    @State var isDone: Bool = false
    
    @State var observations: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas turpis nunc, dignissim eu molestie eu, convallis finibus velit. Fusce et diam diam. Etiam ligula lectus, venenatis luctus nisl tincidunt, varius pulvinar lacus. Suspendisse interdum quam sed est tincidunt, id convallis tortor pretium. In vehicula sollicitudin purus, eget scelerisque mauris viverra vel. Nullam interdum turpis tincidunt sem mattis, ut faucibus augue rutrum. Ut vulputate, sapien et aliquet mattis, odio enim mattis felis, ut volutpat mi quam ultrices magna. Maecenas viverra scelerisque ipsum, vitae feugiat odio varius at. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Integer et ipsum quis nisl rhoncus congue."
    
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
                
                TextEditor(text: $observations)
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            .background(Color.white)
            .clipShape(RoundedCorners(corners: [.topLeft, .topRight], radius: 16))
            .offset(y: -16)
        }
        .background(Color.white)
    }
}

struct StepSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StepSheetView()
    }
}
