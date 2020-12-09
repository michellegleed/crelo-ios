//
//  PledgeForm.swift
//  crelo
//
//  Created by michelle gleed on 6/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct PledgeForm: View {
 
    @EnvironmentObject var userAuthToken: AuthToken
    
    // checking we got the correct response from POST request...
    @State var project: ProjectDetailed   {
        didSet {
            pledgeTypeSymbol = getPledgeTypeSymbol()
        }
    }
    
    @State var pledgeTypeSymbol = ""
    
    @State var amount = 0
    @State var comment = ""
    @State var anonymous = false
    
    func getPledgeTypeSymbol() -> String {
        switch project.pledgetype {
        case 1: return "($)"
        case 2: return "(hrs)"
        default: return ""
        }
    }
    
    
    func savePledge() {
        
        let body = CreatePledge(amount: amount, comment: comment, anonymous: anonymous)

        guard let encodedBody = try? JSONEncoder().encode(body) else {
            print("Failed to encode new project details")
            return
        }
        
        fetch(type: CreatePledge.self, url: "https://warm-atoll-31648.herokuapp.com/projects/\(project.id)/pledges/", method: "POST", token: userAuthToken.token, body: encodedBody) { data, error in
            if error == nil {
                print("yay! no errors in pledge post request")
//                self.project = data
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    
    
    var body: some View {
        VStack {
//                NavigationView {
                    VStack {
                        Spacer()
                        HStack {
                            Text(project.title)
                                .font(.custom("ShadowsIntoLight", size: 48))
                            Spacer()
                        }.padding(48)
                        Spacer()
                        
                        Form {
                            Section {
                                Text("Make A Pledge")
                                    .font(.custom("ShadowsIntoLight", size: 28))
                                
                                TextField("Amount", value: $amount, formatter: NumberFormatter())
                                TextField("Comment", text: $comment)
                                Toggle("Anonymous", isOn: $anonymous)
                                   
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        savePledge()
                                    }) {
                                        Text("Send Pledge")
                                    }.padding(.horizontal, 8.0)
                                    .padding(.vertical, 4.0)
                                    .foregroundColor(Color.white)
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .border(Color.green, width: 1)
                                    Spacer()
                                }
                                .padding(.vertical, 24)
                                
                                
                            }
                        }
                        .background(Color(.white))
                    }
//                }
//            }
        }
        .onAppear()
    }
}

//struct PledgeForm_Previews: PreviewProvider {
//    static var previews: some View {
//        PledgeForm()
//    }
//}
