//
//  ButtonModifier.swift
//  crelo
//
//  Created by michelle gleed on 10/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI



struct CenteredButtonModifier: ViewModifier {
    
    var backgroundColour: Color
    var foregroundColour: Color
    var borderColour: Color
    var fontWeight: String
    
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .font(.custom("Ubuntu-\(fontWeight)", size: 14.0))
                .padding(.horizontal, 8.0)
                .padding(.vertical, 4.0)
                .foregroundColor(foregroundColour)
                .background(backgroundColour)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColour, lineWidth: 1)
                )
            Spacer()
        }
    }
}

extension View {
    func centeredButtonMod(backgroundColour: Color, foregroundColour: Color, borderColour: Color, fontWeight: String) -> some View {
        
        self.modifier(CenteredButtonModifier(backgroundColour: backgroundColour, foregroundColour: foregroundColour, borderColour: borderColour, fontWeight: fontWeight))
    }
    
    func centeredButtonMod(isActive: Bool, fontWeight: String) -> some View {
        
        let backgroundColour: Color = isActive ? .green : .white
        let foregroundColour: Color = isActive ? .white : .black
        let borderColour: Color = isActive ? .green : .black
        
        return self.modifier(CenteredButtonModifier(backgroundColour: backgroundColour, foregroundColour: foregroundColour, borderColour: borderColour, fontWeight: fontWeight))
    }
}
