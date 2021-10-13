//
//  ProjectNameAlert.swift
//  WIMS
//
//  Created by Thiago Medeiros on 08/10/21.
//

import SwiftUI

struct ProjectNameAlert: View {
    @Binding var text: String
    
    @available(iOS 15.0, *)
    @FocusState private var isTyping: Bool
    
    var onSubmit: () -> Void = {}
    var onClose: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Qual o nome do projeto?")
                        .font(.headline)
                    Spacer()
                    
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .font(.caption2.bold())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(y: -8)
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    if #available(iOS 15.0, *) {
                        TextField("Projeto", text: $text)
                            .frame(height: 24)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .wimsShadow()
                            .submitLabel(.search)
                            .onSubmit {
                                onSubmit()
                            }
                            .focused($isTyping)
                    } else {
                        TextField("Placeholder", text: $text, onCommit: onSubmit)
                            .frame(height: 24)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .wimsShadow()
                    }
                    
                    Button(action: {
                        if #available(iOS 15.0, *) {
                            isTyping = false
                        } else {
                            // Dismiss keyboard prior to iOS 15
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        
                        onSubmit()
                    }) {
                        Image(systemName: "arrow.right")
                            .frame(width: 32, height: 32)
                            .font(.body.bold())
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(16)
            .frame(width: 290, height: 102, alignment: .center)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.6).edgesIgnoringSafeArea(.all))
    }
}

struct ProjectNameAlert_Previews: PreviewProvider {
    static var previews: some View {
        ProjectNameAlert(text: .constant(""))
    }
}
