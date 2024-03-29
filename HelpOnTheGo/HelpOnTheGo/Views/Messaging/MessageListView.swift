//
//  MessageListView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

struct MessageListView: View {
    var messages: [Message] // load from db
    @State var selectedMessage: Message? = nil
    @State var toggleMessageChat: Bool = false
    @State var shouldShowNewMessage: Bool = false
    @State var chatUser: ChatUser?
    @ObservedObject private var vm = MessageViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                header

                Divider()

                ForEach(messages, id: \.id) { message in
                    MessageCell(message: message)
                        .onTapGesture {
                            self.selectedMessage = message
                            
                            withAnimation {
                                self.toggleMessageChat.toggle()
                            }
                        }
                    Divider()
                }

                NavigationLink(
                    destination: MessagePersonView(chatUser: self.chatUser),
                    isActive: $toggleMessageChat, label: { EmptyView() }
                )
            }
        }
    }
    
    private var header: some View {
        VStack {
            Text("Messages")
                .foregroundColor(.backgroundColor)
                .font(.largeTitle)
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 35, height: 35)

                VStack(alignment: .leading) {
                    Text("Email: \(vm.chatUser?.email ?? "")")
                        .fontWeight(.bold)
                    HStack {
                        Text("online")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 15, height: 15)
                    }
                }

                Spacer(minLength: 0)

                Image(systemName: "message")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        self.shouldShowNewMessage.toggle()
                    }
                    .fullScreenCover(isPresented: $shouldShowNewMessage, onDismiss: nil) {
                        NewMessageView(didSelectNewUser: { user in
                            self.toggleMessageChat.toggle()
                            self.chatUser = user
                        })
                    }
                
            }.padding()
        }
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView(messages: [Message(sender: "matt", body: "Hey!"),
                                  Message(sender: "evan", body: "lol!")])
    }
}
