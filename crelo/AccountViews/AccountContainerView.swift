//
//  AccountContainerView.swift
//  crelo
//
//  Created by michelle gleed on 12/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct AccountContainerView: View {
    
    @EnvironmentObject var userAuthToken: AuthToken
    
    @State var account: Account?
    
    @State var selection = 0
    
    func loadUserAccount() {
        fetch(type: Account.self, url: "https://warm-atoll-31648.herokuapp.com/account/", method: "GET", token: userAuthToken.token, body: nil) { data, error in
            if error == nil {
                self.account = data
            } else {
                print("error passed to completion handler: ", error)
            }
        }
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                HStack {
                    Button("Profile") {
                        selection = 0
                    }
                    .centeredButtonMod(isActive: selection == 0, fontWeight: "Light")
                    
                    Button("My Projects") {
                        selection = 1
                    }
                    .centeredButtonMod(isActive: selection == 1, fontWeight: "Light")
                    
                    Button("Log Out") {
                        selection = 2
                    }
                    .centeredButtonMod(isActive: selection == 2, fontWeight: "Light")
                }.padding(.vertical, 24)

                
                if #available(iOS 14.0, *) {
                    TabView(selection: $selection) {
                        VStack {
                            ProfileView(account: account, geometryWidth: geometry.size.width)
                        }
                            .tag(0)
                        VStack {
                            MyProjectsView(account: account)
                        }
                            .tag(1)
                        Text("Third")
                            .tag(2)
                    }
//                    .tabViewStyle(PageTabViewStyle())
                    /// Hide the dots
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                else {
                    TabView(selection: $selection) {
                        VStack {
                            ProfileView(account: account, geometryWidth: geometry.size.width)
                        }
                            .tag(0)
                        Text("Second")
                            .tag(1)
                        Text("Third")
                            .tag(2)
                    }
                }
//                HStack {
//                    Button("Profile") {
//                        selection = 0
//                    }
//                    .centeredButtonMod(isActive: selection == 0, fontWeight: "Light")
//
//                    Button("My Projects") {
//                        selection = 1
//                    }
//                    .centeredButtonMod(isActive: selection == 1, fontWeight: "Light")
//
//                    Button("Log Out") {
//                        selection = 2
//                    }
//                    .centeredButtonMod(isActive: selection == 2, fontWeight: "Light")
//                }.padding(.vertical, 24)
            }
        }.onAppear {
            loadUserAccount()
        }
    }
}

struct AccountContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AccountContainerView()
    }
}
