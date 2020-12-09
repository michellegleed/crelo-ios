//
//  LastChanceActivity.swift
//  crelo
//
//  Created by michelle gleed on 6/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct LastChanceActivity: View {
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
                                Image(systemName: "exclamationmark.circle.fill")
                                    .font(.system(size: 16.0, weight: .bold))
                                Text("Last Chance")
                            }
                            .activityTypeMod()
                            Spacer()
                        }.padding(16)
                        
                        Spacer()
                        HStack{
                            Text(self.activityItem.project.title)
                                .padding(.horizontal, 12.0)
                                .frame(width: geometry.size.width)
                                .multilineTextAlignment(.leading)
                                .background(Color("cardBackground"))
                                
                                .font(.custom("ShadowsIntoLight", size: 28))
                        }
                    }
                }.frame(width: geometry.size.width, height: 300)
                
                
                VStack {
                    HStack {
                        Text(LastChanceActivity.getDaysRemaining(date: activityItem.project.due_date))
                            .font(.subheadline)
                            .padding(8.0)
                        Spacer()
                    }
                        .font(.subheadline)
                    Text(activityItem.info)
                    Spacer()
                        Text(LastChanceActivity.isoToDate(date: activityItem.date))
                }.activityFooterMod(geometryWidth: geometry.size.width)
            }
        }
    }
}
