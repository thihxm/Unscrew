//
//  HomeProjectsView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI

struct HomeProjectsView: View {
    @State var selectedStatuses: Set<Status> = []
    @State var searchText: String = ""
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(maximum: 160), spacing: 24), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Text("WIMS")
                    .font(.largeTitle.bold())
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 16)
            
            VStack(alignment: .center, spacing: 24) {
                SearchBar(text: $searchText)
                StatusSelector(selectedStatuses: $selectedStatuses)
            }
            .padding(.horizontal, 24)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<8) { _ in
                        ProjectCard(projectTitle: "Teste", isDone: true)
                    }
                }
                .padding(.top, 8)
                .padding(.horizontal, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct HomeProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeProjectsView()
    }
}
