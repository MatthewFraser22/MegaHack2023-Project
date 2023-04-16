//
//  PostView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

struct PostView: View {
    @State var showCreatePost: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var createPostVM = CreatePostViewModel.shared

    var body: some View {
        ZStack {
            ScrollView {
                ForEach(createPostVM.userPosts) { post in
                    Text("POST " + post.user)
                    
                    Divider()
                }
            }

            createPostView
        }
        .fullScreenCover(isPresented: $showCreatePost) {
            CreatePostView()
                .environmentObject(authViewModel)
        }
    }

    private var createPostView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()

                Button(action: {
                    self.showCreatePost.toggle()
                }, label: {
                    Image(systemName: "square.and.pencil")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                        .background(Color.backgroundColor)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                    
            })
            }
        }
        .padding(.trailing, 20)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
