//
//  View+Shadow.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import Foundation
import SwiftUI

extension View {
    func wimsShadow() -> some View {
        self.modifier(WIMSShadow())
    }
    
    func wimsInnerShadow() -> some View {
        self.modifier(WIMSInnerShadow())
    }
}
