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
    case lastChance
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
            else if cardType == .lastChance {
                LastChanceActivity(activityItem: $activityItem)
            }
            else {
                VStack {
                    //                    Text("not an actvitiy")
                    //                        .font(.headline)
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
                    ImageFromURL(url: self.activityItem.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    
                    
                    VStack {
                        HStack {
                            HStack {
                                Image("light-icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                    .clipped()
                                Text("New")
                                    .font(.custom("Ubuntu", size: 14))
                                    .foregroundColor(Color("cardText"))
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal, 16.0)
                            .padding(/*@START_MENU_TOKEN@*/.vertical, 8.0/*@END_MENU_TOKEN@*/)
                            .background(Color("cardBackground"))
                            .cornerRadius(10)
                            Spacer()
                        }.padding(.horizontal, 16.0)
                        .padding(.vertical, 16.0)
                        
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
                    ImageFromURL(url: self.activityItem.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    
                    
                    VStack {
                        HStack {
                            HStack {
                                Image("trophy-icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                    .clipped()
                                Text("Milestone")
                                    .font(.custom("Ubuntu", size: 14))
                                    .foregroundColor(Color("cardText"))
                            }
                            .padding(.horizontal, 16.0)
                            .padding(/*@START_MENU_TOKEN@*/.vertical, 8.0/*@END_MENU_TOKEN@*/)
                            .background(Color("cardBackground"))
                            .cornerRadius(10)
                            Spacer()
                        }.padding(.horizontal, 16.0)
                        .padding(.vertical, 16.0)
                        
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
                    HStack {
                        Text("\(String(activityItem.project.last_milestone))% Milestone")
                            .font(.subheadline)
                            .padding(.vertical, 8.0)
                        Spacer()
                    }
                    .font(.subheadline)
                    if activityItem.project.pledgetype == 1 {
                        Text("WooHoo! People in your community have pledged $\(String(activityItem.project.current_amount_pledged!)) towards this project")
                            .font(.custom("Ubuntu-Light", size: 16))
                    }
                    else if activityItem.project.pledgetype == 2 {
                        Text("WooHoo! People in your community have pledged \(String(activityItem.project.current_amount_pledged!)) hours towards this project")
                            .font(.custom("Ubuntu-Light", size: 16))
                    }
                }
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
                    ImageFromURL(url: self.activityItem.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    
                    
                    VStack {
                        HStack {
                            HStack {
                                Image(systemName: "chart.bar.xaxis")
                                    .font(.system(size: 16.0, weight: .bold))
                                Text("Progress Update")
                                    .font(.custom("Ubuntu", size: 14))
                                    .foregroundColor(Color("cardText"))
                            }
                            .padding(.horizontal, 16.0)
                            .padding(/*@START_MENU_TOKEN@*/.vertical, 8.0/*@END_MENU_TOKEN@*/)
                            .background(Color("cardBackground"))
                            .cornerRadius(10)
                            Spacer()
                        }.padding(.horizontal, 16.0)
                        .padding(.vertical, 16.0)
                        
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
                    HStack {
                        Text("\(activityItem.project.user)'s update:")
                            .font(.subheadline)
                            .padding(.vertical, 8.0)
                        Spacer()
                    }
                    Text(activityItem.info)
                        .font(.custom("Ubuntu-Light", size: 16))
                        .multilineTextAlignment(.leading)
                    HStack{
                        Spacer()
                        Text("Friday, 9 October 2020")
                            .font(.system(size: 12))
                            .foregroundColor(Color("cardText"))
                    }
                }.padding(.all, 12.0)
                .frame(width: geometry.size.width)
            }
        }.frame(height: 500)
        .background(Color("cardBackground"))
        .padding(.bottom, 12.0)
        .padding(.top, 12.0)
    }
}


struct LastChanceActivity: View {
    @Binding var activityItem: Activity
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(spacing: 0) {
                ZStack {
                    ImageFromURL(url: self.activityItem.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    
                    
                    VStack {
                        HStack {
                            HStack {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .font(.system(size: 16.0, weight: .bold))
                                Text("Last Chance")
                                    .font(.custom("Ubuntu", size: 14))
                                    .foregroundColor(Color("cardText"))
                            }
                            .padding(.horizontal, 16.0)
                            .padding(/*@START_MENU_TOKEN@*/.vertical, 8.0/*@END_MENU_TOKEN@*/)
                            .background(Color("cardBackground"))
                            .cornerRadius(10)
                            Spacer()
                        }.padding(.horizontal, 16.0)
                        .padding(.vertical, 16.0)
                        
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
                    HStack {
                        Text("Closing in 2 days")
                            .font(.subheadline)
                            .padding(.vertical, 8.0)
                        Spacer()
                    }
                        .font(.subheadline)
                    Text("Hey guys, here's a quick update. We've been working hard behind the scenes to get this project off the ground.")
                        .font(.custom("Ubuntu-Light", size: 16))
                    HStack{
                        Spacer()
                        Text("Friday, 9 October 2020")
                            .font(.system(size: 12))
                            .foregroundColor(Color("cardText"))
                    }
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
