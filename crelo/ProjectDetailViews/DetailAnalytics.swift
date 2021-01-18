//
//  DetailAnalytics.swift
//  crelo
//
//  Created by michelle gleed on 15/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct DetailAnalytics: View {
    
    var project: ProjectDetailed
    var geometryWidth: CGFloat
    
    var body: some View {
        VStack {
            Text("Project Stats")
                .font(.custom("ShadowsIntoLight", size: 28))
                .padding(.vertical, 4.0)
            if project.view_count != nil {
                Text("Total Page Views: \(project.view_count!)")
                    .padding(.vertical, 4.0)
                //                    .font(.custom("Ubuntu-Light", size: 12))
            }
            if project.pledge_count != nil {
                Text("Total Pledge Count: \(project.pledge_count!)")
                    .padding(.vertical, 4.0)
                //                .font(.custom("Ubuntu-Light", size: 12))
            }
            if project.average_pledge != nil {
                if project.pledgetype == 1 {
                    Text("Average Pledge: $\(String(format: "%.2f", project.average_pledge!))")
                        .padding(.vertical, 4.0)
                }
                if project.pledgetype == 2 {
                    Text("Average Pledge: \(String(format: "%.2f", project.average_pledge!)) hrs")
                        .padding(.vertical, 4.0)
                }
            }
            if project.conversion_rate != nil {
                Text("Conversion Rate: \(String(format: "%.2f", project.conversion_rate!))%")
                    .padding(.vertical, 4.0)
            }
        }
        .font(.custom("Ubuntu-Light", size: 16))
        .padding(.vertical, 12.0)
        .frame(width: geometryWidth - 48.0)
        .background(Color(.darkText))
        .foregroundColor(Color(.white))
        .cornerRadius(20.0)
        
    }
}

struct DetailAnalytics_Previews: PreviewProvider {
    static var previews: some View {
        DetailAnalytics(project: load("project-detail.json"), geometryWidth: 280.0)
    }
}
