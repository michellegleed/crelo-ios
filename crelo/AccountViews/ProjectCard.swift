//
//  ProjectCard.swift
//  crelo
//
//  Created by michelle gleed on 14/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct ProjectCard: View {
    
    var project: ProjectForAccountModel
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0) {
                ZStack {
                    ImageFromURL(url: project.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    
                    
                    VStack {
                        Spacer()
                        HStack{
                            Text(project.title)
                                .padding(.horizontal, 12)
                                .frame(width: geometry.size.width)
                                .background(Color("cardBackground"))
                                .font(.custom("ShadowsIntoLight", size: 28))
                        }
                    }
                }.frame(width: geometry.size.width, height: 300)
                
                VStack {
                    Text(project.description)
                        .padding(12.0)
                    Spacer()
                        Text(NewProjectActivity.isoToDate(date: project.date_created))
                            .activityFooterMod(geometryWidth: geometry.size.width)
                }
            }
        }
        .activityCardMod()
    }
}

