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
    @Published var refreshPost: Bool = false
    static let shared = CreatePostViewModel()
    private var cancellables: Set<AnyCancellable> = []

    init() {}

    func getAllPost() {
        NetworkServices.getAllPosts() { result in
            switch result {
            case .success(let posts):
                print("SUCCESS: Setting user posts \(posts)")
                self.userPosts = posts
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
                self.$refreshPost
                    .receive(on: RunLoop.main)
                    .sink { _ in
                        self.refreshPost.toggle()
                    }.store(in: &self.cancellables)
                
//                guard let data = data else {
//                    return
//                }
//
//                do {
//                    let dataValue = String(data: data, encoding: .utf8)
//                    print("POST VALUE: \(dataValue)")
//                   let response = try JSONDecoder().decode(User.self, from: data)
//                    DispatchQueue.main.async {
//                        print("UPLOAD POST REPONSE \(response)")
//                    }
//                } catch let e {
//                    print("1. error \(e.localizedDescription)")
//                }
//
////                do {
////                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
////                    let userJson = json["user"] as! [String : Any]
////                    let user = try JSONSerialization.data(withJSONObject: userJson)
////                    let response = try JSONDecoder().decode(User.self, from: user)
////                    DispatchQueue.main.async { [self] in
////                        CreatePostViewModel.getAllPost(userId: response._id)
////                    }
////                } catch let e {
////                    print("ERROR: cannot decode \(e)")
////                }

            case .failure(let error):
                print("FAILURE TO DECODE RESPONSE \(error.localizedDescription)")
                print(error.localizedDescription)
            }
        }
    }
}
