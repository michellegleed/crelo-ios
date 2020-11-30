//
//  NewProject.swift
//  crelo
//
//  Created by michelle gleed on 23/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct NewProjectForm: View {
    
    @State var categories = [Category]()
    @State var pledgeTypes = [PledgeType]()
    @EnvironmentObject var userAuthToken: AuthToken
    
    @State var category = 0
    @State var image = ""
    @State var title = ""
    @State var venue = ""
    @State var description = ""
    @State var pledgeType = 0 {
        didSet {
            pledgeTypeSymbol = getPledgeTypeSymbol()
        }
    }
    @State var fundingTarget: Int?
    @State var goal_amount: Int = 0
    
    @State var dueDate = Date()
    @State var due_date = ""
    
    @State var pledgeTypeSymbol = ""
    
    // checking we got the correct response from POST request...
    ///    @State var project: ConfirmNewProject?
    @Binding var project: ConfirmNewProject?
    
    func getPledgeTypeSymbol() -> String {
        switch pledgeType {
        case 1: return "($)"
        case 2: return "(hrs)"
        default: return ""
        }
    }
    
    func fetchCategories () {
        guard let url = URL(string:"https://warm-atoll-31648.herokuapp.com/project-categories/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Token \(userAuthToken.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode([Category].self, from: data) {
                    DispatchQueue.main.async {
                        self.categories = decodedResponse
                        print(self.categories)
                    }
                    return
                }
                
                /// Use bang operator (see immediately below) for finding the codable errors (the above fails silently without throwing an error).
                //                                var decodedResponse = try! JSONDecoder().decode([Location].self, from: data)
                //                                return
                
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
    }
    
    func fetchPledgeTypes () {
        guard let url = URL(string:"https://warm-atoll-31648.herokuapp.com/pledges/types/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Token \(userAuthToken.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode([PledgeType].self, from: data) {
                    DispatchQueue.main.async {
                        self.pledgeTypes = decodedResponse
                        print(self.pledgeTypes)
                    }
                    return
                }
                
                /// Use bang operator (see immediately below) for finding the codable errors (the above fails silently without throwing an error).
                //                                var decodedResponse = try! JSONDecoder().decode([Location].self, from: data)
                //                                return
                
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
    }
    
    
    
    func getFormData() {
        fetchCategories()
        fetchPledgeTypes()
    }
    
    func saveProject () {
        // I moved this func to a View extension..
        due_date = NewProjectForm.dateToIso(date: self.dueDate)
        
        if let ft = fundingTarget {
            goal_amount = ft
        }
        
        /// post to api
        
        let body = CreateProject(title: title, venue: venue, description: description, pledgetype: pledgeType, goal_amount: goal_amount, image: image, due_date: due_date, category: category)
        
        print("body = ", body)
        
        
        guard let encodedBody = try? JSONEncoder().encode(body) else {
            print("Failed to encode new project details")
            return
        }
        
        print("enocded body = ", encodedBody)
        
        guard let url = URL(string: "https://warm-atoll-31648.herokuapp.com/projects/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Token \(userAuthToken.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = encodedBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(ConfirmNewProject.self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        self.project = decodedResponse
                        print("successfully posted new project")
                    }
                    // everything is good, so we can exit
                    return
                }
                
                
                //                                var decodedResponse = try! JSONDecoder().decode(ConfirmNewProject.self, from: data)
                //                                print("post request successful!")
                //                                return
                
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error decoding response")")
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error - no data..?")")
        }.resume()
    }
    
    var body: some View {
        VStack {
            if categories.count > 0 && pledgeTypes.count > 0 {
                NavigationView {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Create A Project")
                                .font(.custom("ShadowsIntoLight", size: 48))
                            Spacer()
                        }.padding(48)
                        Spacer()
                        
                        Form {
                            Section {
                                TextField("Title", text: $title)
                                TextField("Venue", text: $venue)
                                TextField("Project Description", text: $description)
                                Section {
                                    Picker(selection: $pledgeType, label: Text("What will users be pledging?")) {
                                        ForEach(pledgeTypes, id: \.id) { pledgeType in
                                            Text(pledgeType.type)
                                        }
                                    }.navigationBarTitle("What will users be pledging?")
                                }
                                TextField("Image URL", text: $image)
                                Picker(selection: $category, label: Text("Category")) {
                                    ForEach(categories, id: \.id) { category in
                                        Text(category.name)
                                    }
                                }.navigationBarTitle("Category")
                                TextField("Funding Target \(getPledgeTypeSymbol())", value: $fundingTarget, formatter: NumberFormatter())
                                DatePicker(selection: $dueDate, in: Date()..., displayedComponents: .date) {
                                    Text("Funding end date")
                                }
                                   
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        saveProject()
                                    }) {
                                        Text("Save")
                                    }.padding(.horizontal, 8.0)
                                    .padding(.vertical, 4.0)
                                    .foregroundColor(Color.white)
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .border(Color.green, width: 1)
                                    Spacer()
                                }
                                .padding(.vertical, 24)
                                
                                
                            }.navigationBarTitle("", displayMode: .inline)
                        }.navigationBarTitle("")
                        .background(Color(.white))
                    }
                }
            }
        }
        .onAppear(perform: getFormData)
    }
}

//struct NewProject_Previews: PreviewProvider {
//    static var previews: some View {
//        NewProject()
//    }
//}
