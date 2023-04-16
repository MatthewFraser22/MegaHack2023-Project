//
//  MessagePersonView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI
import Firebase

struct FirebaseConstants {
    static let fromID = "fromId"
    static let toId = "toId"
    static let text = "text"
}

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
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errormessage = "failed to listen for messages \(error)"
                    return
                }
                
                querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                    let data = queryDocumentSnapshot.data() // contains one message block
                    let documentId = queryDocumentSnapshot.documentID

                    self.chatMessages.append(.init(documentId: documentId, data: data))
                })
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
        
        document.setData(messageData) { error in
            if let error = error {
                print(error)
                self.errormessage = "failed to save message to firestore \(error)"
                return
            }

            print("Recipent Successfully saved current users sending message")
        }
    }
}

struct MessagePersonView: View {
    var chatUser: ChatUser?
    @ObservedObject var vm: MessagePersonViewModel

    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = MessagePersonViewModel(chatUser: chatUser)
    }

    var body: some View {
        ZStack {
            main
            Text(vm.errormessage)
        }
        
    }
    
    private var main: some View {
        VStack {
            userHeading
            messagesView
        }
    }

    private var userHeading: some View {
        Text(chatUser?.email ?? "")
            .foregroundColor(.backgroundColor)
            .fontWeight(.bold)
    }

    private var messagesView: some View {
        ScrollView {
            ForEach(vm.chatMessages) { message in
                HStack {
                    Spacer()

                    HStack {
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
            }

            HStack { Spacer() }
        }
        .background(Color(.init(white: 0.96, alpha: 1)))
        .safeAreaInset(edge: .bottom) {
            bottomBar
                .background(Color(.systemBackground).ignoresSafeArea())
        }
    }

    private var bottomBar: some View {
        HStack {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
            TextField("Description", text: $vm.chatText)
            // TextEditor(text: $chatText)
            Button {
                vm.handleSend()
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.backgroundColor)
            .cornerRadius(8)

        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct MessagePersonView_Previews: PreviewProvider {
    static var previews: some View {
        MessagePersonView(
            chatUser: ChatUser(data: ["name" : "Matt"]))
    }
}
