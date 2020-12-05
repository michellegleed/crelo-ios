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
    
    @EnvironmentObject var userAuthToken: AuthToken
    
    @State var project: ProjectDetailed?
    
//    func loadProject() {
//
//        guard let projectId = projectId else {
//            print("no id! returning early.")
//            return
//        }
//
//        guard let url = URL(string:"https://warm-atoll-31648.herokuapp.com/projects/\(projectId)/") else {
//            print("Invalid URL")
//            return
//        }
//
//        print(url)
//
//        var request = URLRequest(url: url)
//        request.addValue("Token \(userAuthToken.token)", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                print(data)
//                if let decodedResponse = try? JSONDecoder().decode(ProjectDetailed.self, from: data) {
//                    DispatchQueue.main.async {
//                        self.project = decodedResponse
//                    }
//                    return
//                }
//                //                                var decodedResponse = try! JSONDecoder().decode(ProjectDetailed.self, from: data)
//                //                                return
//                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
//            }
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
//        }.resume()
//
//    }
    
    func loadProject() {

        guard let projectId = projectId else {
            print("no id! returning early.")
            return
        }

        fetch(type: ProjectDetailed.self, url: "https://warm-atoll-31648.herokuapp.com/projects/\(projectId)/", method: "GET", token: userAuthToken.token, body: nil) { data, error in
                if error == nil {
                    self.project = data
                } else {
                    print("error passed to completion handler: ", error)
                }
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            if let project = project {
                ScrollView {
                    VStack {
                        DetailHeader(project: project, geometryWidth: geometry.size.width)
                        
                        if project.view_count != nil {
                            DetailAnalytics(project: project, geometryWidth: geometry.size.width)
                            //                                .padding(.horizontal, 24)
                        } else {
                            Button("Pledge To This Project") {
                                ///push to pledge view
                            }
                            .padding(.horizontal, 8.0)
                            .padding(.vertical, 4.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        }
                        
                        FirstDetailCard(date: ProjectDetail.isoToDate(date: project.date_created), description: project.description)
                        
                        if let updates = project.updates {
                            ForEach(updates, id: \.id) { update in
                                DetailCard(date: ProjectDetail.isoToDate(date: update.date), description: update.content, imageURL: update.image, geometryWidth: geometry.size.width)
                            }
                        }
                        
                        if let pledges = project.pledges {
                            VStack {
                                ForEach(pledges, id: \.id) { pledge in
                                    PledgeCard(pledge: pledge)
                                }
                            }.background(Color(.gray))
                        }
                    }
                    .font(.custom("Ubuntu-Light", size: 18))
                }
            }
        }.onAppear(perform: loadProject)
    }
}


/// To load the mock json data for preview provider...
func load<T:Decodable>(_ filename:String, as type:T.Type = T.self) -> T {
    let data:Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError()          }// 3
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError()
    }//4
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError()
    }
}

struct ProjectDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        ProjectDetail(projectId: 1, project: load("project-detail.json"))
    }
}
