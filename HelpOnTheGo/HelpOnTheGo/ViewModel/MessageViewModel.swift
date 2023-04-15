//
//  MessageViewModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import Foundation

struct ChatUser {
    let uid: String
    let email: String
}

class MessageViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?

    init() {
        fetchCurrentUser()
    }

    private func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        self.errorMessage = "\(uid)"
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "could not find user with uid \(uid)"
                return
            }

            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }

            // self.errorMessage = "Data: \(data)"

            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            self.chatUser = ChatUser(uid: uid, email: email)
        }
    }
}
