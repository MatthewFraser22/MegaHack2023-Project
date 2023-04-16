//
//  AuthViewModel.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation

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

    static let shared = AuthViewModel()

    init() {

    }

    func login(email: String, password: String) {
        NetworkServices.login(email: email, password: password) { result in
            switch result {
            case .success(let data):
                do {
                   let response = try JSONDecoder().decode(ApiResponse.self, from: data!)
                    DispatchQueue.main.async { [self] in

                        self.currentUser = response.user
                        print("TESTING: = \(currentUser) \(response)")
                    }
                } catch let e {
                    print("TESTING: Error decoding \(e)")
                }

            case .failure(let error):
                print("TESTING: FAILURE \(error)")
                print(error.localizedDescription)
            }
        }
    }

    func create(email: String, password: String) {
        NetworkServices.createNewUser(name: email, email: email, password: password) { result in
            switch result {
            case .success(let data):
                do {
                   let response = try JSONDecoder().decode(ApiResponse.self, from: data!)
                    DispatchQueue.main.async { [self] in
                        
                        self.currentUser = response.user
                        print("CURRENT USER = \(currentUser) \(response)")
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
