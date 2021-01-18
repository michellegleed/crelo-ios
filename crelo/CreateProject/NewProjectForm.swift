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
    @Binding var project: ConfirmNewProject?
    
    func getPledgeTypeSymbol() -> String {
        switch pledgeType {
        case 1: return "($)"
        case 2: return "(hrs)"
        default: return ""
        }
    }
    
    
    func fetchCategories() {
        
        fetch(type: [Category].self, url: "https://warm-atoll-31648.herokuapp.com/project-categories/", method: "GET", token: userAuthToken.token, body: nil) { data, error in
            if error == nil {
                self.categories = data!
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    

    func fetchPledgeTypes() {
        
        fetch(type: [PledgeType].self, url: "https://warm-atoll-31648.herokuapp.com/pledges/types/", method: "GET", token: userAuthToken.token, body: nil) { data, error in
            if error == nil {
                self.pledgeTypes = data!
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    
    func getFormData() {
        fetchCategories()
        fetchPledgeTypes()
    }
    
    
    func saveProject() {
        
        // I moved this func to a View extension..
        due_date = NewProjectForm.dateToIso(date: self.dueDate)
        
        if let ft = fundingTarget {
            goal_amount = ft
        }
        
        let body = CreateProject(title: title, venue: venue, description: description, pledgetype: pledgeType, goal_amount: goal_amount, image: image, due_date: due_date, category: category)

        guard let encodedBody = try? JSONEncoder().encode(body) else {
            print("Failed to encode new project details")
            return
        }
        
        fetch(type: ConfirmNewProject.self, url: "https://warm-atoll-31648.herokuapp.com/projects/", method: "POST", token: userAuthToken.token, body: encodedBody) { data, error in
            if error == nil {
                self.project = data
            } else {
                print("error passed to completion handler: ", error)
            }
        }
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
                                    .buttonStyle(ButtonAnimator())
                                    
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

