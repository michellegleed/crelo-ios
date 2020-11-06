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
        VStack(spacing: 0) {
            Text("New Project Card")
            
            ZStack {
                ImageFromURL(url: self.activityItem.project.image)
                    .aspectRatio(contentMode: .fill)
                VStack {
                    Spacer()
                    HStack{
                        Text(self.activityItem.project.title)
                            .font(.custom("ShadowsIntoLight", size: 22))
                            .foregroundColor(Color.white)
                        
                        
                        if self.activityItem.project.venue != "" {
                            Text("@ \(self.activityItem.project.venue)")
                                .font(.custom("ShadowsIntoLight", size: 22))
                                .foregroundColor(Color.white)
                            
                        }
                    }
                    .background(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3))
                }
                
            }
            
            Text(self.activityItem.project.description)
                .font(.custom("Ubuntu-Light", size: 18))
                .padding()
                .background(Color(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, opacity: 0.55))
            
            /// "more" button -> NAVIGATION LINK to project detail
        }
    }
}

struct MilestoneActivity: View {
    @Binding var activityItem: Activity
    
    var body: some View {
        VStack {
            Text("Milestone Card")
            Text(String(activityItem.project.last_milestone))
                .font(.headline)
            if activityItem.project.pledgetype == 2 {
                Text("WooHoo! So far $\(String(activityItem.project.current_amount_pledged!)) has been pledged for \(activityItem.project.title)")
                    .font(.subheadline)
            }
            else if activityItem.project.pledgetype == 3 {
                Text("WooHoo! So far (String(activityItem.project.current_amount_pledged!)) hours have been pledged for \(activityItem.project.title)")
                    .font(.subheadline)
            }
            Text(activityItem.project.description)
                .font(.body)
            /// "more" button -> NAVIGATION LINK to project detail
        }
    }
}

struct ProgressUpdateActivity: View {
    @Binding var activityItem: Activity
    
    var body: some View {
        VStack {
            Text("Progress Update Card")
            Text(activityItem.project.title)
                .font(.headline)
            if activityItem.project.venue != "" {
                Text("@ \(activityItem.project.venue)")
                    .font(.subheadline)
            }
            
            Text(activityItem.info)
                .font(.body)
            
            /// "more" button -> NAVIGATION LINK to project detail
        }
    }
}

//struct ActivityCard_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ActivityCard(cardType: .newProject, activityItem: Activity())
//    }
//}
