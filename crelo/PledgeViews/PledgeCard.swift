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
        Spacer()
            .padding(.vertical, 8)
        VStack {
            if pledge.type_id == 1 {
                Text("$\(pledge.amount)")
                    .font(.custom("Grandstander-Bold", size: 56))
                
            } else if pledge.type_id == 2 {
                Text("\(pledge.amount) hrs")
                    .font(.custom("Grandstander-Bold", size: 56))
            }
            Text(pledge.comment)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .padding(.vertical, 12)
            HStack {
                if pledge.anonymous {
                    Image(systemName: "person.fill")
                        .font(.system(size: 24.0, weight: .bold))
                        .foregroundColor(.green)
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                    .padding(.vertical, 24)
                    .padding(.horizontal, 12)
                } else {
                    if pledge.user.image != "" {
                    ImageFromURL(url: pledge.user.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(25)
                        .clipped()
                    } else {
                        Image(systemName: "person.fill")
                            .font(.system(size: 24.0, weight: .bold))
                            .foregroundColor(.green)
                            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
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
                        
                    }.padding(.vertical, 24)
                    .padding(.horizontal, 12)
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
