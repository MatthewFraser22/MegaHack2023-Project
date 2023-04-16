//
//  CreatePostView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var vm = CreatePostViewModel()
    @EnvironmentObject private var auth: AuthViewModel

    @State var location: String = ""
    @State var bodyText: String = ""
    @State var helpType: HelpState = .other
    @State var toggleHelp: Bool = false

    var body: some View {
        VStack {
            topBar

            VStack {
                if bodyText.isEmpty {
                    VStack {
                        Text("Type your post!")
                            .foregroundColor(.gray)
                            .fontWeight(.medium)
                        Divider()
                            .foregroundColor(.gray)
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                    }
                }

                MultilineTextFeildRepresentable(text: $bodyText)
                    .frame(height: 300, alignment: .center)

                CustomAuthTextField(placeholder: "Enter your location", isSecureTxtField: false, text: $location)
                
                Toggle(isOn: $toggleHelp) {
                    Text(toggleHelp ? HelpState.other.rawValue : HelpState.needsHelp.rawValue)
                }

                Spacer()

                Button {
                    
                    helpType = toggleHelp ? HelpState.other : HelpState.needsHelp

                    print("CURRENT USER = \(auth.currentUser)")
                    if let user = auth.currentUser {
                        let post = PostItem(
                            id: auth.currentUser?._id ?? "",
                            user: user,
                            bodyText: bodyText,
                            helpState: helpType.rawValue,
                            location: location
                        )

                        vm.uploadPost(postItem: post)
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
                    
                } label: {
                    Text("Post")
                        .foregroundColor(.white)
                        
                }
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 25)
                .background(Color.backgroundColor)
                .cornerRadius(8)

            }
            .padding()

            Spacer()
        }
    }

    private var topBar: some View {
        ZStack {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }

                Spacer()
            }.padding(.leading)

            Text("Post")
                .foregroundColor(.backgroundColor)
                .font(.system(size: 40))
                .fontWeight(.semibold)
        }
        
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
