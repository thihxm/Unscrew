//
//  Shadow.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import Foundation
import SwiftUI

struct WIMSShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
    }
}

struct WIMSInnerShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
    }
}
