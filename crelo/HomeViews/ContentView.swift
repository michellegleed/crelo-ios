//
//  ContentView.swift
//  crelo
//
//  Created by michelle gleed on 7/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
//    @State var authUser: User?
    
    @EnvironmentObject var userAuthToken: AuthToken
    
    var body: some View {
        return Group {
            Text("some view")
            if userAuthToken.token != "" {
                AuthenticatedView()
            } else {
                LogInView()
            }
        }
        
//        PreviewNewsFeed()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
