//
//  PostModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation

struct PostModel: Codable, Identifiable {
    var motive: String
    var location: String
    var text: String
    var user: String
    var id: String
}
