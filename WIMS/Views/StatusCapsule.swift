//
//  StatusCapsule.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import SwiftUI

struct StatusCapsule: View {
    var status: Status
    var isSelected: Bool
    
    var body: some View {
        Text(status.rawValue)
            .padding(.horizontal, 40)
            .padding(.vertical, 8)
            .foregroundColor(isSelected ? .white : .black)
            .background(isSelected ? Color.black : Color.white)
            .clipShape(Capsule())
            .wimsShadow()
    }
}

struct StatusCapsule_Previews: PreviewProvider {
    static var previews: some View {
        StatusCapsule(status: .open, isSelected: false)
        StatusCapsule(status: .done, isSelected: true)
    }
}
