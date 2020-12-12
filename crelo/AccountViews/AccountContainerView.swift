//
//  AccountContainerView.swift
//  crelo
//
//  Created by michelle gleed on 12/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct AccountContainerView: View {
    
    @State var selection = 0
    
    var body: some View {
        if #available(iOS 14.0, *) {
            TabView {
                Text("First")
                    .tabItem {
                        VStack {
                        Button("First") {
                           selection = 0
                        }
                        .centeredButtonMod(backgroundColour: .white, foregroundColour: .black, borderColour: .black, fontWeight: "Light")
                        Spacer()
                        }
                    }
                    .tag(0)
                Text("Second")
                    .tabItem {
                        Button("Second") {
                           selection = 0
                        }
                    }
                    .tag(1)
                Text("Third")
                    .tabItem {
                        Button("Third") {
                           selection = 0
                        }
                    }
                    .tag(2)
            }
//            .tabViewStyle(PageTabViewStyle())
//            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        } else {
            // Fallback on earlier versions
        }
    }
}

struct AccountContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AccountContainerView()
    }
}
