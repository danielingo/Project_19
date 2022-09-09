//
//  SetList.swift
//  Project_19
//
//  Created by Natasha Bohra on 9/8/22.
//

import Foundation
struct SetList {
    var title: String
    var date: Date
}
#if DEBUG
extension SetList{
    static var sampleData = [
        SetList(title: "Beach View", date: Date().addingTimeInterval(100)),
        SetList(title: "City View", date: Date().addingTimeInterval(200)),
        SetList(title: "Apartment View", date: Date().addingTimeInterval(300)),
        SetList(title: "Mountain View", date: Date().addingTimeInterval(400)),
        SetList(title: "Tech View", date: Date().addingTimeInterval(500))
    ]
}
#endif
