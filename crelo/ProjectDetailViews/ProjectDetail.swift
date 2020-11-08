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
    
    @State var project: Project?
    
    func loadProject() {
        
        guard let projectId = projectId else {
            print("no id! returning early.")
            return
        }
        
        guard let url = URL(string:"https://warm-atoll-31648.herokuapp.com/projects/\(projectId)/") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(Project.self, from: data) {
                    DispatchQueue.main.async {
                        self.project = decodedResponse
                    }
                    return
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
    }
    
    var body: some View {
        if let projectId = projectId {
            Text(String(projectId))
        }
        Text(project?.title ?? "project detail page")
            .onAppear(perform: loadProject)
    }
}

struct ProjectDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetail()
    }
}
