//
//  CodableModels.swift
//  crelo
//
//  Created by michelle gleed on 8/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import Foundation

//  👩🏼‍🏫 KEEPING VIEWS IN SYNC WITH STATE - observable object so swift will watch it for changes. the @Published on a variable means that when that variable changes, any elements of a view that refers to this variable will update to reflect the changes.

//  If I want this ObservableObject to be @Published, it means that I have to write out the codingkeys, encode and decode functions explicitly - it's just how @Published works.

//  I added the "Final" keyword so no subclassing because if I subclass this, I'd have to make sure I override the init method and probably add the new CodingKeys and it's just too messy.

final class User: ObservableObject, Codable {
    var id: Int
    var is_admin: Bool
    var username: String
    var email: String
    var location_id: Int
    var bio: String
    var image: String
    var favourite_categories: [Int]
    
//    enum CodingKeys: CodingKey {
//        case username
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        username = try container.decode(String.self, forKey: .username)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(username, forKey: .username)
//    }
}


struct Response: Codable {
    var users: [User]
}



//https://cryptic-thicket-43517.herokuapp.com/locations/1/

final class ProgressUpdate: ObservableObject, Codable {
    var id: Int
    var user: Int
    var project_id: Int
    var date_posted: String
    var content: String
}

final class Project: ObservableObject, Codable {
    var id: Int
    var title: String
    var venue: String
    var description: String
    var pledgetype: Int
    var goal_amount: Int
    var image: String
    var is_open: Bool
    var date_created: String
    var user: Int
    var due_date: String
    var category: Int
    var location_id: Int
    var last_milestone: Int
    var last_chance_triggered: Bool
    var current_amount_pledged: Int?
    var current_percentage_pledged: Float
    var updates: [ProgressUpdate]?
}

final class Activity: ObservableObject, Codable {
    var id: Int
    var action: String
    var datetime: String
    var user_id: Int
    var location_id: Int
    var project_id: Int
    var project: Project
}

final class LocationData: ObservableObject, Codable {
    var id: Int
    var name: String
    var activity: [Activity]
}


