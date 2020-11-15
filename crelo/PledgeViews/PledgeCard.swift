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
            } else if pledge.type_id == 2 {
                Text("\(pledge.amount) hrs")
            }
            Text("\(pledge.comment)")
            HStack {
                if pledge.anonymous {
                    Image(systemName: "person.fill")
                        .font(.system(size: 24.0, weight: .bold))
                        .foregroundColor(.green)
                        VStack {
                            Text("Anonymous")
                            Text("\(pledge.date)")
                        }
                } else {
            ImageFromURL(url: pledge.user.image)
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(25)
                .clipped()
                VStack {
                    Text("\(pledge.user.username)")
                    Text("\(pledge.date)")
                }
            }
            }
                
        }.padding(.vertical, 36)
        .foregroundColor(Color(.lightText))
        
    }
}

//struct PledgeCard_Previews: PreviewProvider {
//    static var previews: some View {
////        PledgeCard(pledge: )
//    }
//}
