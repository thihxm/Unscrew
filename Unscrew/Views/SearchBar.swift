//
//  SearchBar.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @available(iOS 15.0, *)
    @FocusState private var isTyping: Bool
    
    var search: () -> Void = {}
    
    var body: some View {
        HStack {
            if #available(iOS 15.0, *) {
                TextField("Placeholder", text: $text)
                    .frame(height: 32)
                    .submitLabel(.search)
                    .onSubmit {
                        search()
                    }
                    .focused($isTyping)
            } else {
                TextField("Placeholder", text: $text, onCommit: search)
                    .frame(height: 32)
            }
            
            Button(action: {
                if #available(iOS 15.0, *) {
                    isTyping = false
                } else {
                    // Dismiss keyboard prior to iOS 15
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                
                search()
            }) {
                Image(systemName: "magnifyingglass")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .clipShape(Circle())
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(16)
        .wimsShadow()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
