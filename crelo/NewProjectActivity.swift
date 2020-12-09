//
//  NewProjectCard.swift
//  crelo
//
//  Created by michelle gleed on 6/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct NewProjectActivity: View {
    var activityItem: Activity
    
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
                                    .activityIconMod()
                                Text("New")
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
                    Text(self.activityItem.project.description)
                        .padding(12.0)
                    Spacer()
                        Text(NewProjectActivity.isoToDate(date: activityItem.date))
                            .activityFooterMod(geometryWidth: geometry.size.width)
                }
            }
        }
        .activityCardMod()
    }
}

//struct NewProjectCard_Previews: PreviewProvider {
//    static var previews: some View {
//        NewProjectActivity()
//    }
//}
