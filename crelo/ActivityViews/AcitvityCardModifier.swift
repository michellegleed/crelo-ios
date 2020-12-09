//
//  AcitvityCardModifier.swift
//  crelo
//
//  Created by michelle gleed on 9/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct ActivityCardModifier: ViewModifier {
    func body (content: Content) -> some View {
        VStack {
            content
        }
        .frame(height: 500)
        .background(Color("cardBackground"))
        .padding(.vertical, 12.0)
        .font(.custom("Ubuntu-Light", size: 16))
        .multilineTextAlignment(.leading)
        .foregroundColor(Color("cardText"))
    }

}

struct ActivityTypeModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
            HStack {
                content
            }
            .font(.custom("Ubuntu", size: 14))
            .padding(.horizontal, 16.0)
            .padding(/*@START_MENU_TOKEN@*/.vertical, 8.0/*@END_MENU_TOKEN@*/)
            .background(Color("cardBackground"))
            .cornerRadius(10)
    }
}

extension Image {
    
        func activityIconMod() -> some View {
            self
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .clipped()
       }
}

struct ActivityCardFooter: ViewModifier {
    
    var geometryWidth: CGFloat
    
    func body(content: Content) -> some View {
        HStack{
            Spacer()
            content
        }
        .font(Font.system(size: 12).weight(.bold))
        .padding(12.0)
        .frame(width: geometryWidth)
    }
}

extension View {
    func activityCardMod() -> some View {
        self.modifier(ActivityCardModifier())
    }
    
    func activityTypeMod() -> some View {
        self.modifier(ActivityTypeModifier())
    }
    
    func activityFooterMod(geometryWidth: CGFloat) -> some View {
        self.modifier(ActivityCardFooter(geometryWidth: geometryWidth))
    }
}
