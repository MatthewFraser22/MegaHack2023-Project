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
            Image(systemName: "person.fill")
                .font(.system(size: 30))
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 44)
                        .stroke(Color.black, lineWidth: 1)
                }
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
        MessageCell(message: Message(sender: "Evan", body: "..."))
    }
}
