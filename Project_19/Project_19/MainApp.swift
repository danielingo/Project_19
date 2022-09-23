//
//  MainApp.swift
//  Project_19
//
//  Created by Linsey on 9/21/22.
//

import UIKit
import RealityKit
import SwiftUI
// import FirebaseCore

// class AppDelegate: NSObject, UIApplicationDelegate {
//     func application(_ application: UIApplication, 
//         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//             FirebaseApp.configure()
            
//             return true
//         }
// }

@main
struct MainApp: App {
    // register app delegate for Firebase setup
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                SetsView(sets: SetListItem.sampleData)
            }
        }
    }
}
