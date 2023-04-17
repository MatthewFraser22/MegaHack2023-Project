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
            RoundedRectangle(cornerRadius: 8)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 250)
                .foregroundColor(Color(.init(white: 0.97, alpha: 1)))
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
                                .foregroundColor(.black)
                                .fontWeight(.heavy)

                            Spacer()

                        }
                        Text(helpState)
                            .foregroundColor(helpState == HelpState.other.rawValue ? .backgroundColor : .red)
                            .fontWeight(.heavy)
                            .padding(.bottom, 2)
                        Text(bodyText)

                        Spacer()
                        
                        HStack {
                            Text("Location: \(location)")
                                .foregroundColor(.secondary)
                                .fontWeight(.medium)

                            Spacer()
    
                            Button {
                                // GO TO MAP PAGE
                            } label: {
                                HStack {
                                    Image(systemName: "mappin")
                                        .foregroundColor(.red)
                                    Text("See user on map")
                                        .foregroundColor(.backgroundColor)
                                        .font(.system(size: 12))
                                }
                            }

                            
                        }
                        
                    }
                    .padding()
                }

            
        }
    }
}

struct PostViewCell_Previews: PreviewProvider {
    static var previews: some View {
        PostViewCell(user: "Matthew", bodyText: "testsfdfsfsdfsfsdfsdfsdfsdfsdfsdfsdfsdfsdfsd", helpState: "needs help", location: "San fran")
    }
}
