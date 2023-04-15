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

    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                Text("Messages")
                    .foregroundColor(.backgroundColor)
                    .font(.largeTitle)
                Image("message")
                    .resizable()
            }

            Divider()

            ForEach(messages, id: \.id) { message in
                MessageCell(message: message)
                    .onTapGesture {
                        self.selectedMessage = message
                        
                        withAnimation {
                            self.toggleMessageChat = true
                        }
                    }
                Divider()
            }
            

            NavigationLink(destination: MessagePersonView(), isActive: $toggleMessageChat, label: { EmptyView() } )
        }
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView(messages: [Message(sender: "matt", body: "Hey!"),
                                  Message(sender: "evan", body: "lol!")])
    }
}
