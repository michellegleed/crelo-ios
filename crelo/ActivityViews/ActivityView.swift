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
    
    @State var locationData = [LocationData]()
    
    func loadLocationData() {
        
        guard let url = URL(string:"https://warm-atoll-31648.herokuapp.com/locations/1/") else {
            print("Invalid URL")
            return
        }
        
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
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
    }
    
    var body: some View {
        return Group {
            if locationData.count > 0 {
                List(locationData[0].activity, id: \.id) { item in
                    
                    if item.action == "progress-update" {
                        ActivityCard(cardType: .progressUpdate, activityItem: item)
                    }
                    else if item.action == "project-created" {
                        ActivityCard(cardType: .newProject, activityItem: item)
                    }
                    else if item.action == "milestone-25" || item.action == "milestone-50" || item.action == "milestone-50" || item.action == "milestone-50" {
                        ActivityCard(cardType: .milestone, activityItem: item)
                    }
                }
            } else {
                Text("No location data")
            }
        }.onAppear(perform: loadLocationData)
    }
}

struct ActivityView_Previews: PreviewProvider {
    
    static var previews: some View {
        ActivityView()
    }
}
