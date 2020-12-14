//
//  ProgressUpdateActivity.swift
//  crelo
//
//  Created by michelle gleed on 6/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct ProgressUpdateActivity: View {
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
                                Image(systemName: "chart.bar.xaxis")
                                    .font(.system(size: 16.0, weight: .bold))
                                Text("Progress Update")
                            }
                            .activityTypeMod()
                            Spacer()
                        }.padding(16)
                        
                        Spacer()
                        HStack{
                            Text(activityItem.project.title)
                                .padding(.horizontal, 12)
                                .frame(width: geometry.size.width)
//                                .multilineTextAlignment(.leading)
                                .background(Color("cardBackground"))
                                
                                .font(.custom("ShadowsIntoLight", size: 28))
//                                .foregroundColor(Color("cardText"))
                        }
                    }
                }.frame(width: geometry.size.width, height: 300)
                
                
                VStack {
                    HStack {
                        Text("\(activityItem.project.user)'s update:")
                            .bold()
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                        Spacer()
                    }
                    Text(activityItem.info)
                        .padding(.horizontal, 12)
                    Spacer()
                        Text(LastChanceActivity.isoToDate(date: activityItem.date))
                            .activityFooterMod(geometryWidth: geometry.size.width)
                    }
            }
        }
        .activityCardMod()
    }
}

