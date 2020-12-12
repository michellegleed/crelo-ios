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
    
    @Binding var isShowingPledgeForm: Bool
    
    @State var pledgeTypeSymbol = ""
    
    // I couldn't get the TextField to update the state when I set is as an Int, even though it's working fine on CreateProject form :/ that's why it's a string this time.
    @State var amount = ""
    
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
        
        let body = CreatePledge(amount: Int(amount) ?? 0, comment: comment, anonymous: anonymous)
        
        guard let encodedBody = try? JSONEncoder().encode(body) else {
            print("Failed to encode new project details")
            return
        }
        
        print(encodedBody)
        
        fetch(type: CreatePledge.self, url: "https://warm-atoll-31648.herokuapp.com/projects/\(project.id)/pledges/", method: "POST", token: userAuthToken.token, body: encodedBody) { data, error in
            if error == nil {
                print("yay! no errors in pledge post request")
                isShowingPledgeForm = false
                //                self.project = data
            } else {
                print("error passed to completion handler: ", error)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    
                    ImageFromURL(url: project.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    VStack {
                        Spacer()
                        HStack {
                            Text(project.title)
                                .frame(width: geometry.size.width)
                                .padding(.horizontal, 12.0)
                                .background(Color("cardBackground"))
                                .font(.custom("ShadowsIntoLight", size: 28))
                            Spacer()
                        }
                    }.padding()
                } .frame(width: geometry.size.width)
                
                
                    
                    Form {
                        Section {
                            Text("Make A Pledge")
                                .font(.custom("ShadowsIntoLight", size: 28))
                            TextField("Amount \(getPledgeTypeSymbol())", text: $amount)
                            TextField("Comment", text: $comment)
                            Toggle("Anonymous", isOn: $anonymous)
                            
                            Button(action: {
                                savePledge()
                            }) {
                                Text("Send Pledge")
                            }.centeredButtonMod(backgroundColour: .green, foregroundColour: .white, borderColour: .green, fontWeight: "Bold")
                            .padding(.vertical, 24)
                            
                            
                        }
                    }
                    .background(Color(.white))
                }
            }
            .onAppear()
        }
    }

    
//    struct PledgeForm_Previews: PreviewProvider {
//        static var previews: some View {
//            PledgeForm(project: load("project-detail.json"))
//        }
//    }

