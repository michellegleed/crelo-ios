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
            //            userCreds = UserCreds(username: username, password: password)
        }
    }
    
    func fetchLocations () {
        guard let url = URL(string:"https://warm-atoll-31648.herokuapp.com/locations/") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode([Location].self, from: data) {
                    DispatchQueue.main.async {
                        self.locations = decodedResponse
                    }
                    return
                }
                
                /// Use bang operator (see immediately below) for finding the codable errors (the above fails silently without throwing an error).
                //                                var decodedResponse = try! JSONDecoder().decode([Location].self, from: data)
                //                                return
                
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
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
        
        guard let url = URL(string: "https://warm-atoll-31648.herokuapp.com/users/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedCreds
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        self.user = decodedResponse
                        self.userCreds.username = username
                        self.userCreds.password = password
                        self.isPresented = false
                    }
                    // everything is good, so we can exit
                    return
                }
                //                var decodedResponse = try! JSONDecoder().decode(User.self, from: data)
                //                print("post request successful!")
                //                return
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
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
                    //                    }.pickerStyle(WheelPickerStyle())
                    //                }
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                signUp()
                            }) {
                                Text("Sign Up")
                            }.padding(.horizontal, 8.0)
                            .padding(.vertical, 4.0)
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .cornerRadius(10)
                            .border(Color.green, width: 1)
                            .navigationBarTitle("")
                            Spacer()
                        }
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
