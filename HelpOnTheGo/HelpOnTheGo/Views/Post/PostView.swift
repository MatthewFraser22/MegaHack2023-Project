//
//  PostView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

struct PostView: View {
    @State var showCreatePost: Bool = false
    @State var refreshView: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var createPostVM = CreatePostViewModel.shared

    var body: some View {
        ZStack {
            ScrollView {
                ForEach(createPostVM.userPosts) { post in
                    PostViewCell(user: post.name, bodyText: post.text, helpState: post.motive, location: post.location)

                    Rectangle()
                        .foregroundColor(.backgroundColor)
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: 1)
                }
            }

            createPostView
        }
        .fullScreenCover(isPresented: $showCreatePost) {
            CreatePostView()
                .environmentObject(authViewModel)
                .onDisappear {
                    self.refreshView.toggle()
                }
        }
        .onChange(of: refreshView) { _ in
            createPostVM.getAllPost()
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
        .padding(.bottom, 35)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
