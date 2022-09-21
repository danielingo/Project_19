//
//  SetsView.swift
//  Project_19
//
//  Created by Linsey on 9/21/22.
//

import SwiftUI

struct SetsView: View {
    let sets: [SetListItems]
    
    var body: some View {
        List {
            ForEach(sets) { s in
                NavigationLink(destination: DetailView(set: s)) {
                    CardView(set: s)
                }
                // .listRowBackground(s.theme.mainColor)
            }
        }
        .navigationTitle("My Sets")
        .toolbar {
            Button(action: {}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Set")
        }
    }
}

struct SetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetsView(sets: SetListItems.sampleData)
        }
    }
}