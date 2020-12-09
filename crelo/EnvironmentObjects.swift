//
//  EnvironmentObjects.swift
//  crelo
//
//  Created by michelle gleed on 15/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import Foundation

// Instantiated in SceneDelegate + attached to ContentView
final class AuthToken: ObservableObject {
    @Published var token = ""
}

// Instantiated in ContentView + attached to LogIn view
final class UserCreds: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var location = 0
}
