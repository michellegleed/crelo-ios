//
//  MyProjectsView.swift
//  crelo
//
//  Created by michelle gleed on 14/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct MyProjectsView: View {
    
    var account: Account?
    
    var body: some View {
        
        return VStack {
            
            if let account = account {
                if account.projects != nil {
                    NavigationView {
                        List(account.projects!, id: \.id) { item in
                                    ZStack {
                                ProjectCard(project: item)
                                NavigationLink(destination: ProjectDetail(projectId: item.id)) {
                                    EmptyView()
                                }
                            }
                        }
                    }.navigationViewStyle(StackNavigationViewStyle())
                }
            }
        }
    }
}

