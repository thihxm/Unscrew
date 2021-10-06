//
//  View+If.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import Foundation
import SwiftUI

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
         if conditional {
             return AnyView(content(self))
         } else {
             return AnyView(self)
         }
     }
}
