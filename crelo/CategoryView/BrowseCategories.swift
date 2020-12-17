//
//  BrowseCategories.swift
//  crelo
//
//  Created by michelle gleed on 17/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct BrowseCategories: View {
    @EnvironmentObject var userAuthToken: AuthToken
    
    @State var projects: [CategoryProject]?
    
    @State var categories: [Category]?
    
    var locationID: Int
    
    @State var selection = 1
    

    
    func loadProjects() {
        fetch(type: [CategoryProject].self, url: "https://warm-atoll-31648.herokuapp.com/locations/\(locationID)/categories/\(selection)/", method: "GET", token: userAuthToken.token, body: nil) { data, error in
            if error == nil {
                self.projects = data
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    
    func loadCategories() {
        fetch(type: [Category].self, url: "https://warm-atoll-31648.herokuapp.com/project-categories/", method: "GET", token: userAuthToken.token, body: nil) { data, error in
            if error == nil {
                self.categories = data
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
     
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ScrollView (.horizontal, showsIndicators: false) {
                    if #available(iOS 14.0, *) {
                        ScrollViewReader { sv in
                            HStack {
                                if let categories = categories {
                                    ForEach(categories, id: \.id) { category in
                                        Button(category.name) {
                                            selection = category.id
                                            loadProjects()
                                            withAnimation {
                                                sv.scrollTo(category.id, anchor: .center)
                                            }
                                        }
                                        .centeredButtonMod(isActive: selection == category.id, fontWeight: "Light")
                                    }
                                }
                            }
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }.padding(.vertical, 24)
                
                    if let projects = projects {
                        NavigationView {
                            List(projects, id: \.id) { item in
                                        ZStack {
                                    CategoryProjectCard(project: item)
                                    NavigationLink(destination: ProjectDetail(projectId: item.id)) {
                                        EmptyView()
                                    }
                                }
                            }
                        }.navigationViewStyle(StackNavigationViewStyle())
                    }
                
            }
        }.onAppear {
            loadCategories()
            loadProjects()
        }
    }
}
    
//        let colors: [Color] = [.red, .green, .blue]
//
//        var body: some View {
//            ScrollView {
//                if #available(iOS 14.0, *) {
//                    ScrollViewReader { value in
//                        Button("Jump to #8") {
//                            value.scrollTo(8)
//                        }
//
//                        ForEach(0..<10) { i in
//                            Text("Example \(i)")
//                                .frame(width: 300, height: 300)
//                                .background(colors[i % colors.count])
//                                .id(i)
//                        }
//                    }
//                } else {
//                    // Fallback on earlier versions
//                }
//            }
//        }
//    }

struct BrowseCategories_Previews: PreviewProvider {
    static var previews: some View {
        BrowseCategories(locationID: 2)
    }
}
