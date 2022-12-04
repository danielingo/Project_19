//
//  LoginPage.swift
//  Project_19
//
//  Created by Kirtana Mogili on 12/3/22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginPageHostingController: UIHostingController<LoginPage> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: LoginPage())
    }
}

struct LoginPage: View {
    @State var isLoading: Bool = false
    @AppStorage("log_status") var log_status = false
    
    var body: some View {
        VStack(spacing: 20){
            Text("Welcome to Project 19")
            Button {
                handleLogin()
            } label: {
                Text("Create Account")
                    .font(.title3)
                    .fontWeight(.medium)
                    .kerning(1.1)
            }
            .padding()
        }
        .overlay(
            ZStack{
                if isLoading{
                    Color.black
                        .opacity(0.25)
                        .ignoresSafeArea()
                    ProgressView()
                        .font(.title2)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        )
    }
    
    func handleLogin(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading = true
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) { [self] user, err in
            if let error = err {
                isLoading = false
                print(error.localizedDescription)
                return
              }

              guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                  isLoading = false
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { result, err in
                isLoading = false
                
                if let error = err {
                    print(error.localizedDescription)
                    return
                  }
                
                guard let user = result?.user else {
                    return
                }
                
                print(user.displayName ?? "Success!")
                
                withAnimation{
                    log_status = true
                    print(log_status)
                }
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
