//
//  PledgeCard.swift
//  crelo
//
//  Created by michelle gleed on 15/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct PledgeCard: View {
    
    var pledge: Pledge
    
    var body: some View {
        VStack {
            if pledge.type_id == 1 {
                Text("$\(pledge.amount)")
                    .font(.custom("Grandstander-Bold", size: 56))
                
            } else if pledge.type_id == 2 {
                Text("\(pledge.amount) hrs")
                    .font(.custom("Grandstander-Bold", size: 56))
            }
            Text("\(pledge.comment)")
                .padding(.vertical, 12)
            HStack {
                if pledge.anonymous {
                    Image(systemName: "person.fill")
                        .font(.system(size: 24.0, weight: .bold))
                        .foregroundColor(.green)
                    VStack {
                        HStack {
                            Text("Anonymous")
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("\(ProjectDetail.isoToDate(date: pledge.date))")
                            Spacer()
                        }
                    }
                    Spacer()
                } else {
                    ImageFromURL(url: pledge.user.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(25)
                        .clipped()
                    VStack {
                        HStack {
                            Text("\(pledge.user.username)")
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("\(ProjectDetail.isoToDate(date: pledge.date))")
                            Spacer()
                        }
                        
                    }.padding(.vertical, 36)
                    .padding(.horizontal, 24)
                }
            }
        }
        .foregroundColor(Color.white)
        .font(.custom("Ubuntu", size: 18))
        .padding(24)
    }
}

//struct PledgeCard_Previews: PreviewProvider {
//    static var previews: some View {
////        PledgeCard(pledge: )
//    }
//}
