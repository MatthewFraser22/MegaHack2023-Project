//
//  AuthViewModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum AuthError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var authToken: String = ""

    static let shared = AuthViewModel()
    private var cancellable: Set<AnyCancellable> = []

    init() {
        print("1. TOKEN auth \(authToken)")
        $authToken
            .receive(on: RunLoop.main)
            .sink { _ in
                print("Set the token? \(self.authToken)")
                CreatePostViewModel.getAllPost(userId: self.currentUser?._id ?? "0")
            }.store(in: &cancellable)
    }

    func login(email: String, password: String) {
        NetworkServices.login(email: email, password: password) { result in
            switch result {
            case .success(let data):
                do {
                   let response = try JSONDecoder().decode(ApiResponse.self, from: data!)
                    DispatchQueue.main.async { [self] in

                        self.currentUser = response.user
                    }
                } catch let e {
                    print("ERROR: cannot decode \(e)")
                }

            case .failure(let error):
                print("Error: FAILURE \(error)")
                print(error.localizedDescription)
            }
        }
    }

    func create(
        email: String,
        password: String,
        completion: @escaping (_ result: Result<Void, Error>) -> Void
    ) {
        NetworkServices.createNewUser(name: email, email: email, password: password) { result in
            switch result {
            case .success(let data):
                do {
                   let response = try JSONDecoder().decode(ApiResponse.self, from: data!)
                    DispatchQueue.main.async { [self] in
                        self.currentUser = response.user
                        completion(.success(Void()))
                        print("SUCCESS: CURRENT USER = \(currentUser) \(response)")
                    }
                } catch let e {
                    completion(.failure(e))
                    print("Error: failed to create user current user = nil \(e.localizedDescription)")
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
