//
//  SetList.swift
//  Project_19
//
//  Created by Natasha Bohra on 9/8/22.
//

import Foundation
import UIKit

struct Set {
    var title: String
    var date: Date
    var image: UIImage
}
#if DEBUG
extension Set {
    static var sampleData = [
        Set(title: "Beach View", date: Date(), image: UIImage(named: "Images/beach.jpeg")!),
        Set(title: "City View", date: Date(), image: UIImage(named: "Images/city.jpeg")!),
        Set(title: "Apartment View", date: Date(), image: UIImage(named: "Images/apartment.jpeg")!),
        Set(title: "Mountain View", date: Date(), image: UIImage(named: "Images/mountain.jpeg")!),
        Set(title: "Tech View", date: Date(), image: UIImage(named: "Images/tech.jpeg")!)
    ]
}
#endif
