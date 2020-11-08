//
//  ProjectDetail.swift
//  crelo
//
//  Created by michelle gleed on 8/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct ProjectDetail: View {
    
    var projectId: Int?
    
    @State var project: ProjectDetailed?
    
    func loadProject() {
        
        guard let projectId = projectId else {
            print("no id! returning early.")
            return
        }
        
        guard let url = URL(string:"https://warm-atoll-31648.herokuapp.com/projects/\(projectId)/") else {
            print("Invalid URL")
            return
        }
        
        print(url)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(ProjectDetailed.self, from: data) {
                    DispatchQueue.main.async {
                        self.project = decodedResponse
                    }
                    return
                }
                //                                var decodedResponse = try! JSONDecoder().decode(ProjectDetailed.self, from: data)
                //                                return
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
    }
    
    var body: some View {
        
        VStack {
            
            if let project = project {
                
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
                        /// Buttons go here
                    }
                }
                HStack {
                    
                }
            }
        }.onAppear(perform: loadProject)
    }
}

struct ProjectDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetail()
    }
}
