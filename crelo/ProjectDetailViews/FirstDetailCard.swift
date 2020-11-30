//
//  FirstDetailCard.swift
//  crelo
//
//  Created by michelle gleed on 15/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct FirstDetailCard: View {
    var date: String
    var description: String
    
    var body: some View {
        VStack {
            HStack {
                Text(date)
                    .font(.custom("Ubuntu-Bold", size: 14))
                    .padding(24)
                Spacer()
            }
            Text(description)
                .padding(.horizontal, 24)
        }
    }
}

struct FirstDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        FirstDetailCard(date: "Date goes here", description: "Is your dog a menace on the road? We are raising money to provide free driving classes to all canines living in the City of South Perth. Term One will cover accelerating, braking and reverse-parallel parking. Treats will be provided, cars will not - each dog must have permission to learn in their owner's car. Let's make our neighborhood streets the safest in the metro area!.")
    }
}
