//
//  LogIn.swift
//  crelo
//
//  Created by michelle gleed on 14/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct LogInView: View {
    
    @State var username = ""
    @State var password = ""
    @State var userToken: Token?
    
    func logIn() {
        
        let login = LogInCredentials(username: username, password: password)
        guard let encodedCreds = try? JSONEncoder().encode(login) else {
            print("Failed to encode login credentails")
            return
        }
        
        guard let url = URL(string: "https://warm-atoll-31648.herokuapp.com/api-token-auth/") else {
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
                if let decodedResponse = try? JSONDecoder().decode(Token.self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        self.userToken = decodedResponse
                        print("successful log in! token = ", self.userToken?.token ?? "")
                    }
                    // everything is good, so we can exit
                    return
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
    }
    
    
    var body: some View {
        return VStack {
            Form {
                TextField("Username:", text: $username)
                SecureField("Password:", text: $password)
                Button("Submit") {
                    print(self.username, self.password)
                    self.logIn()
                    
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
