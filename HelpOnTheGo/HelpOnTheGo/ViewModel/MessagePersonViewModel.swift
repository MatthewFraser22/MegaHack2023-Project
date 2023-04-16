//
//  MessagePersonViewModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation
import Firebase

class MessagePersonViewModel: ObservableObject {
    @Published var chatText = ""
    @Published var errormessage = ""
    @Published var chatMessages = [ChatMessage]()
    let chatUser: ChatUser?

    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        
        fetchMessages()
    }

    private func fetchMessages() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }

        guard let toId = chatUser?.uid else { return }

        FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errormessage = "failed to listen for messages \(error)"
                    return
                }
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
//                querySnapshot?.documents.forEach({ queryDocumentSnapshot in
//                    let data = queryDocumentSnapshot.data() // contains one message block
//                    let documentId = queryDocumentSnapshot.documentID
//
//                    self.chatMessages.append(.init(documentId: documentId, data: data))
//                })
            }
        
    }
    func handleSend() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        guard let toId = chatUser?.uid else { return }
        
        let document = FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = [FirebaseConstants.fromID: fromId, FirebaseConstants.toId: toId, FirebaseConstants.text: self.chatText, "timestamp": Timestamp()] as [String : Any]

        document.setData(messageData) { error in
            if let error = error {
                print(error)
                self.errormessage = "failed to save message to firestore \(error)"
                return
            }

            print("Successfully saved current users sending message")
            self.chatText = ""
        }
        
        let recipentMessageDocument = FirebaseManager.shared.firestore
            .collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        recipentMessageDocument.setData(messageData) { error in
            if let error = error {
                print(error)
                self.errormessage = "failed to save message to firestore \(error)"
                return
            }

            print("Recipent Successfully saved current users sending message")
        }
    }
}
