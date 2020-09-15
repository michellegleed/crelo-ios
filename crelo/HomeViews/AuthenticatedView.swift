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
    
    @State private var users = [User]()
    
    //    @State var locationData = [LocationData]()
    
    func loadUserData() {
        
        guard let url = URL(string: "https://warm-atoll-31648.herokuapp.com/users/") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        self.users = decodedResponse
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
        
        TabView(selection: $selection){
            VStack {
                HStack {
                    Text("Welcome, Evie!")
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                List(users, id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text(item.username)
                            .font(.headline)
                    }
                }
                .onAppear(perform: loadUserData)
                
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
                ActivityView()
                
            }
                
            .tabItem {
                VStack {
                    Image("second")
                    Text("Projects")
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
