//
//  PostItem.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation

struct PostItem: Identifiable {
    var id: String
    var user: User
    var bodyText: String
    var helpState: String
    var location: String
}
