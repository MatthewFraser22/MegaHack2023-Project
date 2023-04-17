//
//  CreatePostViewModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation
import SwiftUI
import Combine

class CreatePostViewModel: ObservableObject {
    @Published var userPosts = [PostModel]()
    static let shared = CreatePostViewModel()
    private var cancellables: Set<AnyCancellable> = []

    init() {}

    func getAllPost() {
        NetworkServices.getAllPosts() { result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.userPosts = posts
                }
                
            case .failure(let failure):
                print("ERROR: failed to set psots")
                print(failure)
            }
        }
    }

    func uploadPost(postItem: PostItem, userId: String) {
        NetworkServices.uploadPost(userId: userId, postItem: postItem) { result in
            switch result {
            case .success(_):
                self.getAllPost()

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
