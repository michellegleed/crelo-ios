//
//  AuthenticatedView.swift
//  crelo
//
//  Created by michelle gleed on 14/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct AuthenticatedView: View {
    
    @State private var tabBarSelection = 0
    
    @State private var account: Account?
    
    
    @State private var locationData: LocationData?
    
    @EnvironmentObject var userAuthToken: AuthToken
    
    func loadUserData() {
        guard let url = URL(string: "https://warm-atoll-31648.herokuapp.com/account/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Token \(userAuthToken.token)", forHTTPHeaderField: "Authorization")
        
        print(request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print("account data size ", data)
                if let decodedResponse = try? JSONDecoder().decode(Account.self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        self.account = decodedResponse
                    }
                    // everything is good, so we can exit
                    return
                }
                //                /// Use bang operator (see immediately below) for finding the codable errors (the above fails silently without throwing an error).
                //                                var decodedResponse = try! JSONDecoder().decode(Account.self, from: data)
                //                                return
                
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding user account response")")
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no account data..?")")
        }.resume()
    }
    
    var body: some View {
        VStack {
        
        if let account = account {
            
            TabView(selection: $tabBarSelection){
                VStack {
                    ActivityView(account: account)
                }
                .tabItem {
                    VStack {
                        Image("first")
                        Text("News Feed")
                    }
                }
                .tag(0)
                
                
                VStack {
                    Text("Browse Categories")
                    //                CategoryView()
                    
                }
                
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Browse")
                    }
                }
                .tag(1)
                
                VStack {
//                    NewProjectForm()
                    NewProjectView(tabBarSelection: $tabBarSelection)
    
                }
                    .tabItem {
                        VStack {
                            Image("second")
                            Text("New Project")
                        }
                    }
                    .tag(2)
                
                Text("My Account")
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image("second")
                            Text("Account")
                        }
                    }
                    .tag(3)
            }
        }
        
        else {
            LoadingView()
        }
        }.onAppear(perform: loadUserData)
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthenticatedView()
    }
}
