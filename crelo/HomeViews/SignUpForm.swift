//
//  SignUpForm.swift
//  crelo
//
//  Created by michelle gleed on 16/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import Combine
import SwiftUI


struct SignUpForm: View {
    @State private var email = ""
    @State private var username = ""
    @State private var location = 1
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var locations = [Location]()
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject var userCreds: UserCreds
    
    @State var user: User? {
        didSet {
            userCreds.username = username
            userCreds.password = password
        }
    }
    
    func fetchLocations() {
        
        fetch(type: [Location].self, url: "https://warm-atoll-31648.herokuapp.com/locations/", method: "GET", token: nil, body: nil) { data, error in
            if error == nil {
                self.locations = data!
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    
    func signUp() {
        
        guard password == confirmPassword else {
            print("Passwords do not match!!")
            return
        }
        
        let signUp = SignUpCredentials(email: email.lowercased(), username: username.lowercased(), password: password, location_id: location)
        
        guard let encodedCreds = try? JSONEncoder().encode(signUp) else {
            print("Failed to encode sign up credentails")
            return
        }
        
        fetch(type: User.self, url: "https://warm-atoll-31648.herokuapp.com/users/", method: "POST", token: nil, body: encodedCreds) { data, error in
            if error == nil {
                self.user = data
                self.isPresented = false
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Text("Sign Up")
                        .font(.custom("ShadowsIntoLight", size: 48))
                    Spacer()
                }.padding(48)
                Spacer()
                Form {
                    TextField("Email", text: $email)
                    TextField("Username", text: $username)
                    SecureField("Password:", text: $password)
                    SecureField("Confirm Password:", text: $confirmPassword)
                    //                if #available(iOS 14.0, *) {
                    //                    Picker(selection: $location, label: Text("Location")) {
                    //                        ForEach(locations, id: \.id) { location in
                    //                            Text(location.name)
                    //                        }
                    //                    }.pickerStyle(InlinePickerStyle())
                    //                } else {
                    Picker(selection: $location, label: Text("Location")) {
                        ForEach(locations, id: \.id) { location in
                            Text(location.name)
                        }
                    }
                    Section {
                            Button(action: {
                                signUp()
                            }) {
                                Text("Sign Up")
                            }.centeredButtonMod(backgroundColour: .green, foregroundColour: .white, borderColour: .green, fontWeight: "Bold")
                            .buttonStyle(ButtonAnimator())
                    }
                }
            }
        }.onAppear(perform: fetchLocations)
    }
}

//struct SignUpForm_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpForm()
//    }
//}
