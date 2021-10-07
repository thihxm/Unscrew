//
//  TabBar.swift
//  WIMS
//
//  Created by Thiago Medeiros on 06/10/21.
//

import SwiftUI

enum Tab {
    case home
    case addProject
}

struct TabBar: View {
    @State var selectedTab: Tab = .home
    
    func selectTab(_ tab: Tab) {
        selectedTab = tab
    }
    
    var body: some View {
        HStack {
            Button(action: {
                selectTab(.home)
            }) {
                Image(systemName: "house")
            }
            
            Spacer()
            
            Button(action: {
                selectTab(.addProject)
            }) {
                Image(systemName: "plus.circle.fill")
            }
        }
        .frame(maxWidth: 224)
        .font(.title)
        .foregroundColor(.white)
        .padding(.horizontal, 32)
        .padding(.vertical, 8)
        .background(Color.black)
        .clipShape(Capsule())
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
