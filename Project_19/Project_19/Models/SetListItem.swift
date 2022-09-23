//
//  SetListItem.swift
//  Project_19
//
//  Created by Linsey on 9/21/22.
//  Code defining SetListItem, and the initial sampleData list
//

import Foundation
// import Firebase

struct SetListItem: Identifiable {
    let id: UUID
    var title: String
    // var setReference: --> link / identifier to DB
    var createdDate: Date
    var editedDate: Date
    var theme: Theme

    init(id: UUID = UUID(), title: String, createdDate: Date, editedDate: Date, theme: Theme) {
        self.id = id
        self.title = title
        // self.setReference = ??? // should be nothing, until user saves
        self.createdDate = createdDate // (get today's date + time)
        self.editedDate = editedDate // (get today's date + time)
        self.theme = theme
    }
}

#if DEBUG
extension SetListItem{
    static var sampleData = [
        SetListItem(title: "Beach View", createdDate: Date().addingTimeInterval(100), editedDate: Date().addingTimeInterval(100), theme: .yellow),
        SetListItem(title: "City View", createdDate: Date().addingTimeInterval(200), editedDate: Date().addingTimeInterval(200), theme: .orange),
        SetListItem(title: "Apartment View", createdDate: Date().addingTimeInterval(300), editedDate: Date().addingTimeInterval(300), theme: .poppy),
        SetListItem(title: "Mountain View", createdDate: Date().addingTimeInterval(400), editedDate: Date().addingTimeInterval(400), theme: .yellow),
        SetListItem(title: "Tech View", createdDate: Date().addingTimeInterval(500), editedDate: Date().addingTimeInterval(500), theme: .orange)
    ]
}
#endif