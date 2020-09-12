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
        VStack {
            Text("New Project Card")
            Text(activityItem.project.title)
                .font(.headline)
            if activityItem.project.venue != "" {
                Text("@ \(activityItem.project.venue)")
                    .font(.subheadline)
            }
            Text(activityItem.project.description)
                .font(.body)
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
            Text("WooHoo! So far $\(String(activityItem.project.current_amount_pledged!)) has been pledged for \(activityItem.project.title)")
                .font(.subheadline)
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
            
            if activityItem.project.updates != nil {
                Text(activityItem.project.updates![0].content)
                    .font(.body)
            }
            
            /// "more" button -> NAVIGATION LINK to project detail
        }
    }
}

//struct ActivityCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityCard()
//    }
//}
