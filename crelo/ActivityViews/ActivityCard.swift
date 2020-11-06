//
//  ActivityCard.swift
//  crelo
//
//  Created by michelle gleed on 9/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

enum ActivityCardType {
    case newProject
    case milestone
    case progressUpdate
}

struct ActivityCard: View {
    var cardType: ActivityCardType
    @State var activityItem: Activity
    
    var body: some View {
        return Group {
            if cardType == .newProject {
                NewProjectActivity(activityItem: $activityItem)
            }
            else if cardType == .milestone {
                MilestoneActivity(activityItem: $activityItem)
            }
            else if cardType == .progressUpdate {
                ProgressUpdateActivity(activityItem: $activityItem)
            }
            else {
                VStack {
                    Text("not an actvitiy")
                        .font(.headline)
                }
                
            }
        }
    }
}

struct NewProjectActivity: View {
    @Binding var activityItem: Activity
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0) {
                ZStack {
                    ImageFromURL(url: self.activityItem.project.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    
                    
                    VStack {
                        Spacer()
                        HStack{
                            Text(self.activityItem.project.title)
                                .padding(.horizontal, 12.0)
                                .frame(width: geometry.size.width)
                                .multilineTextAlignment(.leading)
                                .background(Color("cardBackground"))
                                
                                .font(.custom("ShadowsIntoLight", size: 28))
                                .foregroundColor(Color("cardText"))
                        }
                    }
                }.frame(width: geometry.size.width, height: 300)
                
                VStack {
                    Text(self.activityItem.project.description)
                        .font(.custom("Ubuntu-Light", size: 16))
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        HStack {
                            Spacer()
                            Text("More >")
                                .font(.custom("ShadowsIntoLight", size: 20))
                                .foregroundColor(Color("cardText"))
                        }
                    }
                }
                .padding(.all, 12.0)
                .frame(width: geometry.size.width)
            }
        }.frame(height: 500)
        .background(Color("cardBackground"))
        .padding(.bottom, 12.0)
        .padding(.top, 12.0)
    }
}

struct MilestoneActivity: View {
    @Binding var activityItem: Activity
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(spacing: 0) {
                ZStack {
                    ImageFromURL(url: self.activityItem.project.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    
                    
                    VStack {
                        Spacer()
                        HStack{
                            Text(self.activityItem.project.title)
                                .padding(.horizontal, 12.0)
                                .frame(width: geometry.size.width)
                                .multilineTextAlignment(.leading)
                                .background(Color("cardBackground"))
                                
                                .font(.custom("ShadowsIntoLight", size: 28))
                                .foregroundColor(Color("cardText"))
                        }
                    }
                }.frame(width: geometry.size.width, height: 300)
                
                
                
                VStack {
                    Text("\(String(activityItem.project.last_milestone))% Milestone")
                        .font(.subheadline)
                    if activityItem.project.pledgetype == 1 {
                        Text("WooHoo! People in your community have pledged $\(String(activityItem.project.current_amount_pledged!)) towards this project")
                            .font(.custom("Ubuntu-Light", size: 16))
                    }
                    else if activityItem.project.pledgetype == 2 {
                        Text("WooHoo! People in your community have pledged \(String(activityItem.project.current_amount_pledged!)) hours towards this project")
                            .font(.custom("Ubuntu-Light", size: 16))
                    }
                    /// "more" button -> NAVIGATION LINK to project detail
                }.padding(.all, 12.0)
                .frame(width: geometry.size.width)
            }
        }.frame(height: 500)
        .background(Color("cardBackground"))
        .padding(.bottom, 12.0)
        .padding(.top, 12.0)
    }
}

struct ProgressUpdateActivity: View {
    @Binding var activityItem: Activity
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(spacing: 0) {
                ZStack {
                    ImageFromURL(url: self.activityItem.project.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    
                    
                    VStack {
                        Spacer()
                        HStack{
                            Text(self.activityItem.project.title)
                                .padding(.horizontal, 12.0)
                                .frame(width: geometry.size.width)
                                .multilineTextAlignment(.leading)
                                .background(Color("cardBackground"))
                                
                                .font(.custom("ShadowsIntoLight", size: 28))
                                .foregroundColor(Color("cardText"))
                        }
                    }
                }.frame(width: geometry.size.width, height: 300)
                
                
                VStack {
                    Text("\(activityItem.project.user)'s update:")
                        .font(.subheadline)
                    Text(activityItem.info)
                        .font(.custom("Ubuntu-Light", size: 16))
                    HStack{
                        Spacer()
                        Text("Friday, 9 October 2020")
                            .font(.system(size: 12))
                            .foregroundColor(Color("cardText"))
                    }
                    /// "more" button -> NAVIGATION LINK to project detail
                }.padding(.all, 12.0)
                .frame(width: geometry.size.width)
            }
        }.frame(height: 500)
        .background(Color("cardBackground"))
        .padding(.bottom, 12.0)
        .padding(.top, 12.0)
    }
}

//struct ActivityCard_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ActivityCard(cardType: .newProject, activityItem: Activity())
//    }
//}
