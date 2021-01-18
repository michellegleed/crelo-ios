//
//  LogIn.swift
//  crelo
//
//  Created by michelle gleed on 14/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var userAuthToken: AuthToken
    @EnvironmentObject var userCreds: UserCreds
    
    @State var userToken: Token? {
        didSet {
            //            print("updating auth token enviroment variable")
            self.userAuthToken.token = self.userToken!.token
            //            print("auth token = ", self.userAuthToken.token)
        }
    }
    
    @State var presentSignupSheet = false
    
    func logIn() {
        
        let login = LogInCredentials(username: userCreds.username.lowercased(), password: userCreds.password)
        guard let encodedCreds = try? JSONEncoder().encode(login) else {
            print("Failed to encode login credentails")
            return
        }
        
        fetch(type: Token.self, url: "https://warm-atoll-31648.herokuapp.com/api-token-auth/", method: "POST", token: nil, body: encodedCreds) { data, error in
            if error == nil {
                self.userToken = data
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    
    
    var body: some View {
        return VStack {
            Spacer()
            HStack {
                Text("Log In")
                    .font(.custom("ShadowsIntoLight", size: 48))
                Spacer()
            }.padding(48)
            Spacer()
            Form {
                TextField("Username:", text: $userCreds.username)
                SecureField("Password:", text: $userCreds.password)
                Spacer()
                
                Section{
                    Button("Submit") {
                        print(self.userCreds.username.lowercased(), self.userCreds.password)
                        LoadingView()
                        self.logIn()
                    }
                    .centeredButtonMod(backgroundColour: .green, foregroundColour: .white, borderColour: .green, fontWeight: "Bold")
                    .buttonStyle(ButtonAnimator())
                }
                
                Section {
                    
                    Button(action: {
                        self.presentSignupSheet.toggle()
                    }) {
                        HStack {
                            Spacer()
                            Text("Don't have an account? Sign up.").accentColor(Color.green)
                            Spacer()
                        }
                    }
                    .buttonStyle(ButtonAnimator())
                    .sheet(isPresented: self.$presentSignupSheet) {
                        SignUpForm(isPresented: self.$presentSignupSheet)
                    }
                }
            }
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
