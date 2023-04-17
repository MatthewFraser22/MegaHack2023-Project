//
//  Message.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import Foundation

struct Message: Identifiable, Hashable {
    var sender: String
    var body: String
    var id: UUID { UUID() }
}
