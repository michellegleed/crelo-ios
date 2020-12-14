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
    var activityItem: Activity
    
    
    var body: some View {
        if cardType == .newProject {
            NewProjectActivity(activityItem: activityItem)
        }
        else if cardType == .milestone {
            MilestoneActivity(activityItem: activityItem)
        }
        else if cardType == .progressUpdate {
            ProgressUpdateActivity(activityItem: activityItem)
        }
        else if cardType == .lastChance {
            LastChanceActivity(activityItem: activityItem)
        }
        else {
            VStack {
                Text("Activity not found")
                    .font(.headline)
            }
        }
    }
}

