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
    
//    func printDaysRemaining () {
//        DetailHeader.getDaysRemaining(date: project.due_date)
//    }
    
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
                VStack {
                    //                        NavigationLink(destination: UpdateProject) {
///                    HStack {
///                       Image(systemName: "pencil")
///                            .font(.system(size: 10.0, weight: .bold))
///                        Button("Update Project") {
///                            print("Update project tapped")
///                        }
///                        .font(.custom("Ubuntu-Light", size: 14.0))
///                    }
///                    .padding(.horizontal, 8.0)
///                    .padding(.vertical, 4.0)
///                    .foregroundColor(.black)
///                    .overlay(
///                        RoundedRectangle(cornerRadius: 10)
///                            .stroke(Color.black, lineWidth: 1)
///                    )
                    
                    Button(action: {
                        /// navigate to UpdateProject page
                        print("Update Project btn tapped")
                    }) {
                        Image(systemName: "pencil")
                        .font(.system(size: 10.0, weight: .bold))
                        Text("Update Project")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .centeredButtonMod(backgroundColour: .white, foregroundColour: .black, borderColour: .black, fontWeight: "Light")
                    
                    
                    Spacer()
                    
                    Button(action: {
                        /// close Project early
                        print("Close Project btn tapped")
                    }) {
                        Image(systemName: "multiply.circle")
                        .font(.system(size: 10.0, weight: .bold))
                        Text("Close Project")
                    }.centeredButtonMod(backgroundColour: .white, foregroundColour: .black, borderColour: .black, fontWeight: "Light")
                    
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
                        .frame(width: 16, height: 16)
//                        .clipped()
                    Text(project.location)
                }
                Spacer()
                HStack {
                    Image(systemName: "clock")
                        .font(.system(size: 16))
                    Text(DetailHeader.getDaysRemaining(date: project.due_date))
                }
            }.padding(.horizontal, 24)
            
            Spacer()
                .padding(.vertical, 8)
            
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
                .foregroundColor(Color.green)
                .padding(.vertical, 12)
                HStack {
                    if project.pledgetype == 1 {
                        Text("Pledged: $\(project.current_amount_pledged ?? 0)")
                    }
                    else if project.pledgetype == 2 {
                        Text("Pledged: \(project.current_amount_pledged ?? 0) hrs")
                    }
                    Spacer()
                }
                .padding(.vertical, 12)
            }
            .padding(.horizontal, 24)
            .font(.custom("Grandstander-Bold", size: 24))
        }
    }
}

struct DetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeader(project: load("project-detail.json"), geometryWidth: 320.0)
    }
}
