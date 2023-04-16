//
//  CreatePostViewModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation

class CreatePostViewModel: ObservableObject {
    @Published var userPosts = [PostModel]()
    static let shared = CreatePostViewModel()

    init() { }

    static func getAllPost() {
        NetworkServices.getAllPosts { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func uploadPost(postItem: PostItem) {
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
                print(error.localizedDescription)
            }
        }
    }
}
