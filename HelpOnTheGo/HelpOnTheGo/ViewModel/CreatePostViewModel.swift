//
//  CreatePostViewModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation
import SwiftUI

class CreatePostViewModel: ObservableObject {
    @Published var userPosts = [PostModel]()
    static let shared = CreatePostViewModel()

    init() {}

    static func getAllPost(userId: String) {
        NetworkServices.getAllPosts(userId: userId) { result in
            switch result {
            case .success(let success):
                print("SUCCESS GOT ALL POSTS")
                print(success)
            case .failure(let failure):
                print("FAILURE NOOOOOOO")
                print(failure)
            }
        }
    }

    func uploadPost(postItem: PostItem, token: String) {
        NetworkServices.uploadPost(postItem: postItem) { result in
            switch result {
            case .success(let data):
                do {
                   let response = try JSONDecoder().decode(ApiResponse.self, from: data!)
                    DispatchQueue.main.async {
                        print("UPLOAD POST REPONSE \(response)")
                    }
                } catch let e {
                    print("1. error \(e.localizedDescription)")
                }

            case .failure(let error):
                print("FAILURE TO DECODE RESPONSE \(error.localizedDescription)")
                print(error.localizedDescription)
            }
        }
    }
}
