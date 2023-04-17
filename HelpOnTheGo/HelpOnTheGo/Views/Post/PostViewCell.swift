//
//  PostViewCell.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import SwiftUI

enum HelpState: String, CaseIterable {
    case needsHelp = "Needs Help"
    case other = "Wants to Help"
}

struct PostViewCell: View {
    var user: String
    var bodyText: String
    var helpState: String
    var location: String

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 250)
                .foregroundColor(Color(.init(white: 0.96, alpha: 1)))
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.fill")
                                .font(.system(size: 20))
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color.black, lineWidth: 1)
                                }

                            Text(user)
                                .foregroundColor(.backgroundColor)
                                .fontWeight(.heavy)

                            Spacer()

                        }
                        Text(helpState)
                            .foregroundColor(.backgroundColor)
                            .fontWeight(.heavy)
                        Text(bodyText)

                        Spacer()
                        
                        Text("Location: \(location)")
                            .foregroundColor(.secondary)
                            .fontWeight(.medium)
                    }
                    .padding()
                }

            
        }
    }
}

//struct PostViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PostViewCell(user: User(name: "nil", email: "nil"), bodyText: "testsfdfsfsdfsfsdfsdfsdfsdfsdfsdfsdfsdfsdfsd", helpState: .needsHelp, location: "San fran")
//    }
//}
