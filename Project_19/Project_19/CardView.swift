//
//  CardView.swift
//  Project_19
//
//  Created by Linsey on 9/23/22.
//  Code that creates CardViews for each SetListItem
//

import SwiftUI

struct CardView: View {
    let s: SetListItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(s.title)
                .accessibilityAddTraits(.isHeader)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(s.editedDate)", systemImage: "pencil.and.outline")
                    .accessibilityLabel("last edited on \(s.editedDate)")
                Spacer()
                Label("\(s.createdDate)", systemImage: "doc.badge.plus")
                    .accessibilityLabel("created on \(s.createdDate)")
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(s.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var s = SetListItem.sampleData[0]
    static var previews: some View {
        CardView(set: s)
            .background(s.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
