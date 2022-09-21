//
//  MainApp.swift
//  Project_19
//
//  Created by Linsey on 9/21/22.
//

import UIKit
import RealityKit
import SwiftUI

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SetsView(sets: SetListItems.sampleData)
            }
        }
    }
}