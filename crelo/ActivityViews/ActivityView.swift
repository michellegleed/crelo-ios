//
//  ActivityView.swift
//  crelo
//
//  Created by michelle gleed on 8/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    
    //    var locationData = [DummyLocationData]
    
    var account: Account
    
    @State var locationData = [LocationData]()
    
    func loadLocationData() {
        
        print("user's location id is ", account.location.id)
        
        guard let url = URL(string:"https://warm-atoll-31648.herokuapp.com/locations/\(account.location.id)/") else {
            print("Invalid URL")
            return
        }
        
        print("url is ", url)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(LocationData.self, from: data) {
                    DispatchQueue.main.async {
                        self.locationData = [decodedResponse]
                    }
                    return
                }
                /// Use bang operator (see immediately below) for finding the codable errors (the above fails silently without throwing an error).
//                                var decodedResponse = try! JSONDecoder().decode(LocationData.self, from: data)
//                                return

                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
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

//struct ActivityView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        ActivityView()
//    }
//}
