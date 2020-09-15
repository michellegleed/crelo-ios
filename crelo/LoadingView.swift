//
//  LoadingView.swift
//  crelo
//
//  Created by michelle gleed on 15/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
            .font(.custom("ShadowsIntoLight", size: 64))
            .foregroundColor(.green)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
