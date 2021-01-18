//
//  ProfileView.swift
//  crelo
//
//  Created by michelle gleed on 13/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var account: Account?
    
    var geometryWidth: CGFloat
    
    var body: some View {
        if let account = account {
            ScrollView {
                VStack {
                    Spacer()
                    HStack {
                        Text("My Profile")
                            .font(.custom("ShadowsIntoLight", size: 36))
                            .padding(24)
                        Spacer()
                    }
                    
                    if account.user.image != "" {
                    ImageFromURL(url: account.user.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometryWidth, height: 300)
                        .clipped()
                    }
                    
                    HStack {
                        Text(account.user.username)
                            .font(.custom("ShadowsIntoLight", size: 48))
                        Spacer()
                    }.padding(24)
                    
                    HStack {
                        Image("location-icon")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("City of \(account.location.name)")
                            .font(.custom("Ubuntu-Bold", size: 14))
                        Spacer()
                    } .padding(24)
                    
                    HStack {
                        Text(account.user.bio)
                            .font(.custom("Ubuntu-Light", size: 18))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    } .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    
                    Button(action: {
                        /// edit profile
                    }) {
                        Text("Edit Profile")
                    }.centeredButtonMod(backgroundColour: .white, foregroundColour: .black, borderColour: .black, fontWeight: "Bold")
                }
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(geometryWidth: 280)
//    }
//}


