//
//  StatusSelector.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import SwiftUI

struct StatusSelector: View {
    @Binding var selectedStatuses: Set<Status>
    
    func selectStatus(_ status: Status) {
        let isStatusSelected = selectedStatuses.contains { $0 == status }
        
        if isStatusSelected {
            selectedStatuses.remove(status)
        } else {
            selectedStatuses.insert(status)
        }
    }
    
    var body: some View {
        HStack {
            StatusCapsule(status: .done, isSelected: selectedStatuses.contains(where: { $0 == .done })) {
                selectStatus(.done)
            }
            
            Spacer()
            
            StatusCapsule(status: .open, isSelected: selectedStatuses.contains(where: { $0 == .open })) {
                selectStatus(.open)
            }
        }
        .frame(maxWidth: 294)
    }
}

struct StatusSelector_Previews: PreviewProvider {
    static var previews: some View {
        StatusSelector(selectedStatuses: .constant([]))
    }
}
