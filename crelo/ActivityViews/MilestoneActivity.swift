//
//  MilestoneActivity.swift
//  crelo
//
//  Created by michelle gleed on 6/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import Foundation
import SwiftUI

struct MilestoneActivity: View {
    var activityItem: Activity
    
    func formatPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        if let percentageString = formatter.string(for: Double(activityItem.project.current_percentage_pledged ?? 0)) {
            return percentageString + "%"
        }
        return "0%"
    }
    
    @State private var barWidth: CGFloat = 0
    
    func animateProgressBar(geometryWidth: CGFloat) {
        withAnimation(Animation.easeInOut(duration: 1)) {
            barWidth = geometryWidth * barWidthRatio * (CGFloat(activityItem.project.current_percentage_pledged ?? 0) * 0.01)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(spacing: 0) {
                ZStack {
                    ImageFromURL(url: self.activityItem.image)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                    
                    
                    VStack {
                        HStack {
                            HStack {
                                Image("trophy-icon")
                                    .activityIconMod()
                                Text("Milestone")
                            }
                            .activityTypeMod()
                            Spacer()
                        }.padding(16)
                        
                        
                        
                        Spacer()
                        HStack{
                            Text(self.activityItem.project.title)
                                .padding(.horizontal, 12.0)
                                .frame(width: geometry.size.width)
                                .background(Color("cardBackground"))
                                .font(.custom("ShadowsIntoLight", size: 28))
                        }
                    }
                }.frame(width: geometry.size.width, height: 300)
                
                
                
                VStack {
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(Color.gray)
                            .opacity(0.1)
                            .frame(width: geometry.size.width * barWidthRatio, height: 30)
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                    .fill(barColour)
                                    .frame(width: barWidth, height: 30)
                                HStack {
                                    Spacer()
                                    Text(formatPercentage())
                                        .font(.custom("Ubuntu-Bold", size: 16))
                                        .foregroundColor(.white)
                                        .padding(.trailing, 6)
                                }
                            }.padding(0)
                            .frame(width: barWidth, height: 30)
                            .onAppear {
                                animateProgressBar(geometryWidth: geometry.size.width)
                            }
                            Spacer()
                        }
                        }
                        
                        
                    } .frame(width: geometry.size.width * 0.7, height: 30)
                    .padding(.vertical, 24)
                    
                    HStack {
                        Text("\(String(activityItem.project.last_milestone))% Milestone")
                            .bold()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }.padding(.horizontal, 12)
//                    .font(.subheadline)
                    if activityItem.project.pledgetype == 1 {
                        Text("WooHoo! People in your community have pledged $\(String(activityItem.project.current_amount_pledged!)) towards this project")
                            .padding(.horizontal, 12)
                            .padding(.top, 6)
                            .multilineTextAlignment(.leading)
                    }
                    else if activityItem.project.pledgetype == 2 {
                        Text("WooHoo! People in your community have pledged \(String(activityItem.project.current_amount_pledged!)) hours towards this project")
                            .padding(.horizontal, 12)
                            .padding(.top, 6)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    Text(MilestoneActivity.isoToDate(date: activityItem.date))
                        .activityFooterMod(geometryWidth: geometry.size.width)
            }
        }
        .activityCardMod()
    }
    
    
    // MARK: - Drawing Constants
    
    var barWidthRatio: CGFloat = 0.66
    
    var barHeight: CGFloat = 30
    
    var barColour: Color {
        if let current = activityItem.project.current_percentage_pledged {
            if current < 50 {
                return Color(red: 255.0, green: 0.0, blue: 0.0)
            }
            if current < 100 {
                return .yellow
            }
            return .green
        }
        else {
            return .red
        }
    }
}

