//
//  MilestoneActivity.swift
//  crelo
//
//  Created by michelle gleed on 6/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct MilestoneActivity: View {
    var activityItem: Activity
    
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
                                    .activityIconMod()
                                Text("Milestone")
                            }
                            .activityTypeMod()
                            Spacer()
                        }.padding(16)
                            
                        
                        
                        Spacer()
                        HStack{
                            Text(self.activityItem.project.title)
                                .padding(.horizontal, 12.0)
                                .frame(width: geometry.size.width)
                                .background(Color("cardBackground"))
                                
                                .font(.custom("ShadowsIntoLight", size: 28))
                        }
                    }
                }.frame(width: geometry.size.width, height: 300)
                
                
                
                VStack {
                    HStack {
                        Text("\(String(activityItem.project.last_milestone))% Milestone")
                            .bold()
                            .padding(12)
                        Spacer()
                    }
                    .font(.subheadline)
                    if activityItem.project.pledgetype == 1 {
                        Text("WooHoo! People in your community have pledged $\(String(activityItem.project.current_amount_pledged!)) towards this project")
                    }
                    else if activityItem.project.pledgetype == 2 {
                        Text("WooHoo! People in your community have pledged \(String(activityItem.project.current_amount_pledged!)) hours towards this project")
                    }
                    Spacer()
                        Text(MilestoneActivity.isoToDate(date: activityItem.date))
                            .activityFooterMod(geometryWidth: geometry.size.width)
                }
            }
        }
        .activityCardMod()
    }
}

