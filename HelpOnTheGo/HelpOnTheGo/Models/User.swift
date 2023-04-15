//
//  User.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import Foundation

struct User: Decodable {
    let name: String
    let image: String?
    let userstate: String
}
