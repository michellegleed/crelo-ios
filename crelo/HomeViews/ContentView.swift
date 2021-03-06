//
//  ContentView.swift
//  crelo
//
//  Created by michelle gleed on 7/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userAuthToken: AuthToken
    
    var userCreds = UserCreds()
//    var account = UserAccount()
    
    /// To remove grey background colour from forms (forms inherit from TableView)
    init(){
           UITableView.appearance().backgroundColor = .clear
       }
    
    var body: some View {
        return Group {
            if userAuthToken.token != "" {
                AuthenticatedView()
            }
//            else {
//                if userCreds.username != nil && userCreds.password != nil {
//                    LogInView(username: userCreds!.username, password: userCreds!.password)
//                }
                else {
                    LogInView().environmentObject(userCreds)
                }
            }
            //        AuthenticatedView()
        }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(userCreds: UserCreds()).environmentObject(userAuthToken)
//    }
//}
