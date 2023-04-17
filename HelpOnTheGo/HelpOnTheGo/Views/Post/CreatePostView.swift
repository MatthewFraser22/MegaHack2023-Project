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
    @State var selectedIndex: Int = 0
    var options: [String] = [
        "Needs help", "Wants to help"
    ]

    var body: some View {
        VStack {
            topBar
            VStack(alignment: .center) {

                ZStack(alignment: .topLeading) {
                    MultilineTextFeildRepresentable(text: $bodyText)
                        .frame(height: 300, alignment: .center)
                        .cornerRadius(8)
                    if bodyText.isEmpty {
                        Text("Type your post!")
                            .foregroundColor(.gray)
                            .fontWeight(.medium)
                            .padding()
                    }
                }
                

                CustomAuthTextField(placeholder: "Enter your location", isSecureTxtField: false, text: $location)
                    .padding(.bottom, 15)

                selectMotive

                Spacer()

                Button {
                    if let user = auth.currentUser {
                        let post = PostItem(
                            id: auth.currentUser?._id ?? "",
                            user: user,
                            bodyText: bodyText,
                            helpState: options[selectedIndex],
                            location: location
                        )

                        vm.uploadPost(postItem: post, userId: auth.currentUser?._id ?? "unknown")
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

    private var selectMotive: some View {
        VStack(alignment: .leading) {
            Text("Select the option which you are posting for: ")
                .foregroundColor(.backgroundColor)
                .fontWeight(.medium)
            ForEach(0..<options.count) { id in
                CheckmarkView(id: id, text: options[id], selectedIndex: $selectedIndex)
            }
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
                .fontWeight(.bold)
        }
        
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
