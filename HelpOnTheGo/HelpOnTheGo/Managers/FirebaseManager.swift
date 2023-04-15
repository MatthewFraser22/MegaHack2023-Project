//
//  FirebaseManager.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import Foundation
import Firebase

public class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore

    static let shared = FirebaseManager()

    override init() {
        FirebaseApp.configure()

        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        super.init()
    }
}
