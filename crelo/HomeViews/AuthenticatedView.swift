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

        fetch(type: Account.self, url: "https://warm-atoll-31648.herokuapp.com/account/", method: "GET", token: userAuthToken.token, body: nil) { data, error in
                if error == nil {
                    self.account = data
                } else {
                    print("error passed to completion handler: ", error)
                }
        }
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
                        Image(systemName: "antenna.radiowaves.left.and.right")
                        Text("News Feed")
                    }
                }
                .tag(0)
                
                
                VStack {
//                    Text("Browse Categories")
                    //                CategoryView()
                    if let account = account {
                        BrowseCategories(locationID: account.location.id)
                    }
                    
                }
                .tabItem {
                    VStack {
                        Image(systemName: "newspaper")
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
                            Image(systemName: "pencil.tip.crop.circle")
                            Text("New Project")
                        }
                    }
                    .tag(2)
                
               AccountContainerView()
                    .tabItem {
                        VStack {
                            Image(systemName: "person")
                            Text("Account")
                        }
                    }
                    .tag(3)
            }
            .accentColor(.green)
            .onAppear {
                UITabBar.appearance().barTintColor = .white
            }
        }
        
        else {
            LoadingView()
        }
        }.onAppear{
            loadUserData()
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthenticatedView()
    }
}
