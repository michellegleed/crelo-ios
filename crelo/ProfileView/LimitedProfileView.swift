//
//  LimitedProfileView.swift
//  crelo
//
//  Created by michelle gleed on 18/1/21.
//  Copyright © 2021 michelle gleed. All rights reserved.
//

import SwiftUI

struct LimitedProfileView: View {
        
        var user: LimitedUser
        
        var geometryWidth: CGFloat
        
        var body: some View {
                ScrollView {
                    VStack {
                        Spacer()
                        HStack {
                            Text(user.username)
                                .font(.custom("ShadowsIntoLight", size: 48))
                            Spacer()
                        }.padding(24)
                        if user.image != "" {
                        ImageFromURL(url: user.image)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometryWidth, height: 300)
                            .clipped()
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 92.0, weight: .bold))
                                .foregroundColor(.green)
                                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        
                       
                        
//                        HStack {
//                            Image("location-icon")
//                                .resizable()
//                                .frame(width: 16, height: 16)
//                            Text("City of \(user.location.name)")
//                                .font(.custom("Ubuntu-Bold", size: 14))
//                            Spacer()
//                        } .padding(24)
                        
                        HStack {
                            Text(user.bio)
                                .font(.custom("Ubuntu-Light", size: 18))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        } .padding(.horizontal, 24)
                        .padding(.vertical, 36)
                        
                    }
                }
            }
    }

    //struct ProfileView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        ProfileView(geometryWidth: 280)
    //    }
    //}


