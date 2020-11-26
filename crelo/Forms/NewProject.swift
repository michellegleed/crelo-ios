//
//  NewProject.swift
//  crelo
//
//  Created by michelle gleed on 23/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct NewProject: View {
    
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
    @State var fundingTarget: Float?
    
    @State var dueDate = Date()
    @State var due_date = ""
    
    @State var pledgeTypeSymbol = ""
    
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
        due_date = NewProject.dateToIso(date: self.dueDate)
        /// post to api
    }
    
    var body: some View {
        VStack {
            if categories.count > 0 && pledgeTypes.count > 0 {
                NavigationView {
                
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
                TextField("Image", text: $image)
                Picker(selection: $category, label: Text("Category")) {
                    ForEach(categories, id: \.id) { category in
                        Text(category.name)
                    }
                }.navigationBarTitle("Category")
                TextField("Funding Target \(getPledgeTypeSymbol())", value: $fundingTarget, formatter: NumberFormatter())
                DatePicker(selection: $dueDate, in: Date()..., displayedComponents: .date) {
                                Text("Funding end date")
                            }

                Button(action: {
                saveProject()
                }) {
                    Text("Save")
                }
                }.navigationBarTitle("New Project", displayMode: .inline)
            }.navigationBarTitle("New Project")
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
