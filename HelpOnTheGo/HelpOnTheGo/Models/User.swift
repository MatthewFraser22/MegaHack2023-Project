//
//  User.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import Foundation

struct ApiResponse: Decodable {
    let token: String
}

struct User: Codable {
    let name: String
    let email: String
    let authToken: String
}
