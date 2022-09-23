//
//  DetailView.swift
//  Project_19
//
//  Created by Linsey on 9/21/22.
//  Goal is to replace this placeholder screen with the VR env.
//

import SwiftUI

struct DetailView: View {
    let s: SetListItem

    var body: some View {
        // Text("Hello, World!")
        List {
            Section(header: Text("Set Info")) {
                Label("\(s.title)", systemImage: "timer")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                HStack {
                    Label("Date Created", systemImage: "clock")
                    Spacer()
                    Text("\(s.createdDate)")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Last Edited", systemImage: "clock")
                    Spacer()
                    Text("\(s.editedDate)")
                }
                .accessibilityElement(children: .combine)
                
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(set: SetListItem.sampleData[0])
        }
    }
}