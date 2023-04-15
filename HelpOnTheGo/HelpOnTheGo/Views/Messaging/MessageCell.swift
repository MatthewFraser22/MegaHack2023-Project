//
//  MessageCell.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

struct MessageCell: View {
    var message: Message

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(message.sender)
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                Text(message.body)
                    .fontWeight(.thin)
                    .truncationMode(.tail)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.backgroundColor)

        }.padding()
    }
}

struct MessageCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageCell(message: Message(sender: "Evan", body: "FUCK YOU"))
    }
}
