//
//  MessagePersonView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI
import Firebase

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
                VStack {
                    if message.fromId == FirebaseManager.shared.auth.currentUser?.uid {
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
                    } else {
                        HStack {
                            HStack {
                                Text(message.text)
                                    .foregroundColor(.backgroundColor)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)

                            Spacer()
                        }
                        
                    }
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
