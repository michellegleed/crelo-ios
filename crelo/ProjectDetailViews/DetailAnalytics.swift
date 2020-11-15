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
    
    var body: some View {
        VStack {
            Text("Project Stats")
            if project.view_count != nil {
            Text("Total Page Views: \(project.view_count!)")
            }
            if project.pledge_count != nil {
            Text("Total Pledge Count: \(project.pledge_count!)")
            }
            if project.average_pledge != nil {
            Text("Average Pledge: \(project.average_pledge!)")
            }
            if project.conversion_rate != nil {
            Text("Conversion Rate: \(project.conversion_rate!)")
            }
        }.padding()
        .background(Color(.darkText))
        .foregroundColor(Color(.white))
    }
}

struct DetailAnalytics_Previews: PreviewProvider {
    static var previews: some View {
        DetailAnalytics(project: load("project-detail.json"))
    }
}
