//
//  ChatMessage.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation

struct ChatMessage: Identifiable {
    let fromId: String
    let toId: String
    let text: String
    var id: String { documentId }
    let documentId: String

    init(documentId: String, data: [String : Any]) {
        self.documentId = documentId
        self.fromId = data[FirebaseConstants.fromID] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
    }
}
