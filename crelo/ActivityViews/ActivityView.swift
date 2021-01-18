//
//  ActivityView.swift
//  crelo
//
//  Created by michelle gleed on 8/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    
    var account: Account
    
    @State var locationData = [LocationData]()
    
    func loadLocationData() {
        
        print("user's location id is ", account.location.id)

        fetch(type: LocationData.self, url: "https://warm-atoll-31648.herokuapp.com/locations/\(account.location.id)/", method: "GET", token: nil, body: nil) { data, error in
                if error == nil {
                    self.locationData = [data!]
                } else {
                    print("error passed to completion handler: ", error)
                }
        }
    }
    
    var body: some View {
        return Group {
            
            if locationData.count > 0 {
                NavigationView {
                    List(locationData[0].activity, id: \.id) { item in
                            if item.action == "progress-update" {
                                ZStack {
                                    ActivityCard(cardType: .progressUpdate, activityItem: item)
                                    NavigationLink(destination: ProjectDetail(projectId: item.project_id)) {
                                        EmptyView()
                                    }
                                }
                            }
                            else if item.action == "project-created" {
                                ZStack {
                                    ActivityCard(cardType: .newProject, activityItem: item)
                                    NavigationLink(destination: ProjectDetail(projectId: item.project_id)) {
                                        EmptyView()
                                    }
                                }
                            }
                            else if item.action == "milestone" {
                                ZStack {
                                    ActivityCard(cardType: .milestone, activityItem: item)
                                    NavigationLink(destination: ProjectDetail(projectId: item.project_id)) {
                                        EmptyView()
                                    }
                                }
                            }
                            else if item.action == "last-chance" {
                                ZStack {
                                    ActivityCard(cardType: .lastChance, activityItem: item)
                                    NavigationLink(destination: ProjectDetail(projectId: item.project_id)) {
                                        EmptyView()
                                    }
                                }
                            }
                    }
                }
            } else {
                Text("No location data")
            }
        }.onAppear(perform: loadLocationData)
    }
}
