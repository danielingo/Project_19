//
//  AccountView.swift
//  Project_19
//
//  Created by Kirtana Mogili on 12/3/22.
//

import UIKit
import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct AccountView: View {
    @AppStorage("log_status") var log_status = false
    var body: some View {
        if log_status {
            storyboardview().edgesIgnoringSafeArea(.all)
            NavigationView{
                VStack(spacing: 15){
                    Text("Logged In")
                    Button("Logout") {
                        GIDSignIn.sharedInstance.signOut()
                        try? Auth.auth().signOut()

                        withAnimation{
                            log_status = false
                        }
                    }
                }
            }
        } else {
            LoginPage()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

struct storyboardview: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "NavBar")
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
