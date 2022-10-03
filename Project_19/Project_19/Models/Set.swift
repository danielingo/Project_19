//
//  SetList.swift
//  Project_19
//
//  Created by Natasha Bohra on 9/8/22.
//

import Foundation
struct Set {
    var title: String
    var date: Date
    var image: String
}
#if DEBUG
extension Set {
    static var sampleData = [
        Set(title: "Beach View", date: Date(), image: ""),
        Set(title: "City View", date: Date(), image: ""),
        Set(title: "Apartment View", date: Date(), image: ""),
        Set(title: "Mountain View", date: Date(), image: ""),
        Set(title: "Tech View", date: Date(), image: "")
    ]
}
#endif
