//
//  DetailHeader.swift
//  crelo
//
//  Created by michelle gleed on 15/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct DetailHeader: View {
    
    var project: ProjectDetailed
    var geometryWidth: CGFloat
    
    var body: some View {
        VStack {
        HStack {
            HStack {
                ImageFromURL(url: project.user.image)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                    .clipped()
                VStack {
                    HStack {
                    Text("Created by")
                        .font(.custom("Ubuntu-Light", size: 10))
                        Spacer()
                    }
                    HStack {
                    Text(project.user.username)
                        .font(.custom("ShadowsIntoLight", size: 14))
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        Text(project.title)
            .font(.custom("ShadowsIntoLight", size: 48))
        if project.view_count != nil {
            HStack {
//                        NavigationLink(destination: UpdateProject) {
                    HStack{
                        Image(systemName: "pencil")
                            .font(.system(size: 10.0, weight: .bold))
                        Button("Update Project") {
                            ///push to update page
                        }
                    }
                .padding(.horizontal, 8.0)
                .padding(.vertical, 4.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                .cornerRadius(20)
               
                Spacer()
//                        }
                Button("Close Project") {
                    ///close project early
                } .padding(.horizontal, 8.0)
                .padding(.vertical, 4.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                .cornerRadius(20)
               
            }.padding()
            .padding(.horizontal, 36.0)
        }
            ImageFromURL(url: project.image)
                .aspectRatio(contentMode: .fill)
                .frame(width: geometryWidth, height: 300)
                .clipped()
            HStack {
                HStack {
                    Image("location-icon")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .clipped()
                    Text(project.location)
                }
                HStack {
                    Image(systemName: "clock")
                        .frame(width: 10, height: 10)
                        .clipped()
                    Text("Calculate days remaining here")
                }
            }
            VStack {
                HStack {
                    if project.pledgetype == 1 {
                        Text("Target: $\(project.goal_amount)")
                    }
                    else if project.pledgetype == 2 {
                        Text("Target: \(project.goal_amount) hrs")
                    }
                    Spacer()
                }
                HStack {
                    if project.pledgetype == 1 {
                        Text("Pledged: $\(project.current_amount_pledged ?? 0)")
                    }
                    else if project.pledgetype == 2 {
                        Text("Pledged: \(project.current_amount_pledged ?? 0) hrs")
                    }
                    Spacer()
                }
            }
        }
    }
}

struct DetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeader(project: load("project-detail.json"), geometryWidth: 320.0)
    }
}
