//
//  EditProfileForm.swift
//  crelo
//
//  Created by michelle gleed on 18/1/21.
//  Copyright © 2021 michelle gleed. All rights reserved.
//

import Combine
import SwiftUI


struct EditProfileForm: View {
    
    @EnvironmentObject var userAuthToken: AuthToken
    
    @State var user: User?
    
    @State var location: Int
    @State var bio: String
    @State var image: String
    
    @State private var locations = [Location]()
    
    @Binding var isPresented: Bool
    @Binding var profileWasUpdated: Bool
    
    func fetchLocations() {
        
        fetch(type: [Location].self, url: "https://warm-atoll-31648.herokuapp.com/locations/", method: "GET", token: nil, body: nil) { data, error in
            if error == nil {
                self.locations = data!
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    
    func saveChanges() {
        
        let updatedUser = UpdatedUser(image: image, bio: bio, location_id: location)
        
        guard let encodedUser = try? JSONEncoder().encode(updatedUser) else {
            print("Failed to encode user data")
            return
        }
        
        fetch(type: Account.self, url: "https://warm-atoll-31648.herokuapp.com/account/", method: "PUT", token: userAuthToken.token, body: encodedUser) { data, error in
            if error == nil {
                self.isPresented = false
                self.profileWasUpdated = true
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Text("Edit Profile")
                        .font(.custom("ShadowsIntoLight", size: 48))
                    Spacer()
                }.padding(48)
                Spacer()
                Form {
                    TextField("Profile Image", text: $image)
                    Picker(selection: $location, label: Text("Location")) {
                        ForEach(locations, id: \.id) { location in
                            Text(location.name)
                        }
                    }
                    TextField("Bio:", text: $bio)
                   
                    Section {
                            Button(action: {
                                saveChanges()
                            }) {
                                Text("Save")
                            }.centeredButtonMod(backgroundColour: .green, foregroundColour: .white, borderColour: .green, fontWeight: "Bold")
                            .buttonStyle(ButtonAnimator())
                    }
                }
            }
        }.onAppear(perform: fetchLocations)
    }
}

