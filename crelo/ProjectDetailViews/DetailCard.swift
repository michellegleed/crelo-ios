//
//  DetailCard.swift
//  crelo
//
//  Created by michelle gleed on 15/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct DetailCard: View {
    var date: String
    var description: String
    var imageURL: String
    var geometryWidth: CGFloat
    
    var body: some View {
        VStack {
            ImageFromURL(url: imageURL)
                .aspectRatio(contentMode: .fill)
                .padding(.horizontal, 24)
                .frame(width: geometryWidth, height: 300)
                .clipped()
            HStack {
                Text(date)
                    .font(.custom("Ubuntu-Bold", size: 14))
                Spacer()
            }
            .padding(24)
            Text(description)
                .padding(.horizontal, 24)
        }.frame(width: geometryWidth, height: 600)
        
    }
}

struct DetailCard_Previews: PreviewProvider {
    static var previews: some View {
        DetailCard(date: "Date goes here", description: "Hi Friends! Just a quick update due to some exciting new developments. We have reached out to Uber to gauge their interest in sponsoring our driving lessons! This could be the start of an amazing partnership and a huge opportunity for idle dogs to get involved in the gig-economy.", imageURL: "", geometryWidth: 320)
    }
}
