//
//  AuthenticatedView.swift
//  crelo
//
//  Created by michelle gleed on 14/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct AuthenticatedView: View {
    
    @State private var selection = 0
    
    @State private var account: Account?
    
    @State private var locationData: LocationData?
    
    @EnvironmentObject var userAuthToken: AuthToken
    
    func loadUserData() {
        guard let url = URL(string: "http://localhost:8000/account/") else {
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
                /// Use bang operator (see immediately below) for finding the codable errors (the above fails silently without throwing an error).
                //                var decodedResponse = try! JSONDecoder().decode(Account.self, from: data)
                //                return
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding user account response")")
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no account data..?")")
        }.resume()
    }
    
    func loadNewsFeed() {
        guard let url = URL(string: "http://localhost:8000/locations/1/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Token \(userAuthToken.token)", forHTTPHeaderField: "Authorization")
        
        print(request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(LocationData.self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        self.locationData = decodedResponse
                    }
                    // everything is good, so we can exit
                    return
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding location response")")
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no location data..?")")
        }.resume()
    }
    
    var body: some View {
        
        TabView(selection: $selection){
            VStack {
                HStack {
                    Text("Welcome \(account?.user.username ?? ""),")
                    Spacer()
                }
                .padding()
                .onAppear(perform: loadUserData)
                
                Spacer()
                
                List(locationData?.activity ?? [Activity](), id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text(item.info)
                            .font(.headline)
                    }
                }
                .onAppear(perform: loadNewsFeed)
                
                Spacer()
                
            }
            
            .tabItem {
                VStack {
                    Image("first")
                    Text("Activity Feed")
                }
            }
            .tag(0)
            
            
            VStack {
//                PreviewNewsFeed()
                ActivityView()
                
            }
            
            .tabItem {
                VStack {
                    Image("second")
                    Text("News Feed")
                }
            }
            .tag(1)
            
            Text("My Account")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("My Account")
                    }
                }
                .tag(2)
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthenticatedView()
    }
}
