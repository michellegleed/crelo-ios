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
    var location_id: Int
    var bio: String
    var image: String
    var favourite_categories: [Int]
    var username: String
}
    
final class LimitedUser: ObservableObject, Codable {
    var id: Int
    var username: String
    var image: String
    var bio: String
}
    
final class Location: ObservableObject, Codable {
    var id: Int
    var name: String
}
    
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

struct PledgeType: Codable {
    var id: Int
    var type: String
}


struct LogInCredentials: Codable {
    var username: String
    var password: String
}

struct SignUpCredentials: Codable {
    var email: String
    var username: String
    var password: String
    var location_id: Int
}

struct CreateProject: Codable {
    var title: String
    var venue: String
    var description: String
    var pledgetype: Int
    var goal_amount: Int
    var image: String
    var due_date: String
    var category: Int
}

// I was planning on conforming to Codable manually 😅 so I could make the token variable @Published and save the class to an environment variable, but it didn't like the fact it was codable. So have now made a separate AuthToken class, an instance of which will be saved as the environment variable.
final class Token: ObservableObject, Codable {
    
    var token: String
    
//    @Published var token = ""
//
//    enum CodingKeys: CodingKey {
//        case token
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        token = try container.decode(String.self, forKey: .token)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(token, forKey: .token)
//    }
}


final class ProgressUpdate: ObservableObject, Codable {
    var id: Int
    var user: Int
    var project: Int
    var date: String
    var content: String
    var image: String
}

final class Category: ObservableObject, Codable {
    var id: Int
    var name: String
}

final class ProjectDetailed: ObservableObject, Codable {
    var id: Int
    var title: String
    var venue: String
    var description: String
    var pledgetype: Int
    var goal_amount: Int
    var image: String
    var is_open: Bool
    var date_created: String
    var user: LimitedUser
    var due_date: String
    var category: Int
    var location: String
    var last_milestone: Int
    var last_chance_triggered: Bool
    var current_amount_pledged: Int?
    var current_percentage_pledged: Float?
    var check_for_milestone: Bool?
    var check_close_to_due_date: Bool?
    var updates: [ProgressUpdate]?
    var pledges: [Pledge]?
    var view_count: Int?
    var pledge_count: Int?
    var conversion_rate: Float?
    var average_pledge: Float?
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
    var user: String
    var due_date: String
    var category: Category
    var location: String
    var last_milestone: Int
    var last_chance_triggered: Bool
    var current_amount_pledged: Int?
    var current_percentage_pledged: Float?
    var check_for_milestone: Bool?
    var check_close_to_due_date: Bool?
}

final class CategoryProject: ObservableObject, Codable {
    var id: Int
    var title: String
    var venue: String
    var description: String
    var pledgetype: Int
    var goal_amount: Int
    var image: String
    var is_open: Bool
    var date_created: String
    var user: String
    var due_date: String
    var category: Int
    var location: String
    var last_milestone: Int
    var last_chance_triggered: Bool
    var current_amount_pledged: Int?
    var current_percentage_pledged: Float?
    var check_for_milestone: Bool?
    var check_close_to_due_date: Bool?
}

final class ConfirmNewProject: ObservableObject, Codable {
    var id: Int
    var title: String
    var venue: String
    var description: String
    var pledgetype: Int
    var goal_amount: Int
    var image: String
    var is_open: Bool
    var date_created: String
    var user: String
    var due_date: String
    var category: Int
    var location: String
    var last_milestone: Int
    var last_chance_triggered: Bool
    var current_amount_pledged: Int?
    var current_percentage_pledged: Float?
    var check_for_milestone: Bool?
    var check_close_to_due_date: Bool?
}

final class ProjectForAccountModel: ObservableObject, Codable {
    var id: Int
    var title: String
    var venue: String
    var description: String
    var pledgetype: Int
    var goal_amount: Int
    var image: String
    var is_open: Bool
    var date_created: String
    var user: String
    var due_date: String
    var category: Int
    var location: String
    var last_milestone: Int
    var last_chance_triggered: Bool
    var current_amount_pledged: Int?
    var current_percentage_pledged: Float?
    var check_for_milestone: Bool?
    var check_close_to_due_date: Bool?
}

final class Activity: ObservableObject, Codable {
    var id: Int
    var action: String
    var info: String
    var date: String
    var image: String
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

final class Pledge: ObservableObject, Codable {
    var id: Int
    var amount: Int
    var comment: String
    var anonymous: Bool
    var user: LimitedUser
    var project_id: Int
    var date: String
    var type_id: Int
    var project: ProjectForAccountModel?
}

struct CreatePledge: Codable {
    var amount: Int
    var comment: String
    var anonymous: Bool
}

final class Account: ObservableObject, Codable {
    var user: User
    var location: Location
    var projects: [ProjectForAccountModel]?
    var pledges: [Pledge]?
}
    
