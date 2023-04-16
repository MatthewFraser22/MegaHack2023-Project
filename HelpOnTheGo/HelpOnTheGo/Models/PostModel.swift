//
//  PostModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation

//struct PostModel: Codable, Identifiable {
//    var motive: String
//    var location: String
//    var text: String
//    var user: String
//    var date: String
//    var _id: String
//    var id: String { _id }
//}

struct PostModel: Codable, Identifiable {
    let id, user, motive, text: String
    let name: String
    let avatar: Avatar
    let location, date: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user, motive, text, name, avatar, location, date
        case v = "__v"
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let type: String
    let data: [Int]
}

