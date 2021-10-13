//
//  RoundedCorners.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI

struct RoundedCorners: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
