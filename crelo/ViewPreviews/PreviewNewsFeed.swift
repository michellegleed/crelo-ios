//
//  PreviewNewsFeed.swift
//  crelo
//
//  Created by michelle gleed on 15/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI



struct PreviewNewsFeed: View {
    
    var newProjectTitleString: String {
        // check venue != "" here
        return "Doggy Driving Lessons @ Local School"
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack {
                
                
                VStack(spacing: 0) {
                    ZStack {
                        Image("dog")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        VStack {
                            Spacer()
                            
                            Text(self.newProjectTitleString)
                                .frame(width: geometry.size.width)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 12.0)
                                .background(Color(red: 231.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 0.75))
                           
                                .font(.custom("ShadowsIntoLight", size: 28))
                                .foregroundColor(Color.black)
                        }
                        
                    }.frame(width: geometry.size.width, height: 300)
                    
                    VStack {
                        Text("Learn to drive in a safe, supportive environment. No cats.")
                        
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            HStack {
                                Spacer()
                                Text("More >")
                                    .font(.custom("ShadowsIntoLight", size: 20))
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                    .font(.custom("Ubuntu-Light", size: 18))
                    .padding(.all, 12.0)
                    .frame(width: geometry.size.width)
                    .background(Color(red: 231.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 0.75))
                    
                }.frame(height: 400)
                
                
                                VStack(spacing: 0) {
                                    ZStack {
                                        Image("dog")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                        VStack {
                                            Spacer()
                
                                            Text(self.newProjectTitleString)
                                                .frame(width: geometry.size.width)
                                                .multilineTextAlignment(.leading)
                                                .padding(.horizontal, 12.0)
                                                .background(Color(red: 231.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 0.75))
                                                .font(.custom("ShadowsIntoLight", size: 28))
                                                .foregroundColor(Color.black)
                                        }
                
                                    }.frame(width: geometry.size.width, height: 300)
                
                                VStack {
                                    Text("\(String(25))% Milestone")
                                        .font(.subheadline)
                                    Text("WooHoo! So far $35 has been pledged for Doggy Driving Lessons")
                                        .font(.body)
                                    HStack{
                                        Spacer()
                                        Text("Friday, 9 October 2020")
                                            .font(.body)
                                            .foregroundColor(.init(red: 160.0/255.0, green: 160.0/255.0, blue: 160.0/255.0))
                                    }
                
                                    /// "more" button -> NAVIGATION LINK to project detail
                                }
                                .font(.custom("Ubuntu-Light", size: 18))
                                .padding(.all, 12.0)
                                .frame(width: geometry.size.width)
                                .background(Color(red: 231.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 0.75))
                
                            }.frame(height: 400)
                
                
                VStack(spacing: 0) {
                    ZStack {
                        Image("dog")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        VStack {
                            Spacer()
                            
                            Text(self.newProjectTitleString)
                                .frame(width: geometry.size.width)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 12.0)
                                .background(Color(red: 231.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 0.75))
                                .font(.custom("ShadowsIntoLight", size: 28))
                                .foregroundColor(Color.black)
                        }
                        
                    }.frame(width: geometry.size.width, height: 300)
            
                    VStack {
                        Text("Progress Update")
                            .font(.headline)
                        Text("evie's update:")
                            .font(.subheadline)
                        Text("Hey guys, here's a quick update. We've been working hard behind the scenes to get this project off the ground.")
                            .font(.body)
                        HStack{
                            Spacer()
                            Text("Friday, 9 October 2020")
                                .font(.body)
                                .foregroundColor(.init(red: 160.0/255.0, green: 160.0/255.0, blue: 160.0/255.0))
                        }
                        
                        /// "more" button -> NAVIGATION LINK to project detail
                    }
                    .font(.custom("Ubuntu-Light", size: 18))
                    .padding(.all, 12.0)
                    .frame(width: geometry.size.width)
                    .background(Color(red: 231.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 0.75))
                    
                }.frame(height: 400)
            }
            
        }
    }
}




struct PreviewNewsFeed_Previews: PreviewProvider {
    
    static var previews: some View {
        PreviewNewsFeed()
    }
}
