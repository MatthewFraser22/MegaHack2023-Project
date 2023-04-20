//
//  AuthServices.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation
import SwiftUI

class NetworkServices {

    init() {}

    static func getAllPosts(
        completion: @escaping (_ result: Result<[PostModel], AuthError>) -> Void
    ) {
        let url = URL(string: "http://localhost:5001/api/posts")

        guard let url = url else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                return
            }

            guard let data = data else {
                completion(.failure(.custom(errorMessage: "Error getting data")))
                return
            }

            do {
//                let dataString = String(data: data, encoding: .utf8)
//                print("Raw JSON data: \(dataString ?? "Unable to convert data to string")")
                let response = try JSONDecoder().decode([PostModel].self, from: data)
                print("Post Response \(response)")
                completion(.success(response))
            } catch let error {
                completion(.failure(.custom(errorMessage: error.localizedDescription)))
            }
        }
        task.resume()
        
    }

    static func login(
        email: String,
        password: String,
        completion: @escaping (_ result: Result<Data?, AuthError>) -> Void
    ) {
        makeRequest(
            urlString: "http://localhost:5001/api/auth",
            httpMethod: .post,
            requestBody: ["email" : email, "password" : password]) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    completion(.failure(.invalidCredentials))
                }
            }
    }

    static func uploadPost(
        userId: String,
        postItem: PostItem,
        completion: @escaping (_ result: Result<Data?, AuthError>) -> Void
    ) {
        makePostRequest(
            userId: userId,
            urlString: "http://localhost:5001/api/posts",
            httpMethod: .post,
            requestBody: [
                "text" : postItem.bodyText,
                "motive" : postItem.helpState,
                "name" : postItem.user.name,
                "location" : postItem.location,
                "user" : postItem.user._id
            ]
        ) { result in
                switch result {
                case .success(let data):
                    let stringData = String(data: data!, encoding: .utf8)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.invalidCredentials))
                }
            }
    }

    static func createNewUser(
        name: String,
        email: String,
        password: String,
        completion: @escaping (_ result: Result<Data?, AuthError>) -> Void
    ) {
        makeRequest(
            urlString: "http://localhost:5001/api/users",
            httpMethod: .post,
            requestBody: ["email" : email, "name" : name, "password" : password]
        ) { result in
                switch result {
                case .success(let data):
                    print("SUCCESS: There is data \(String(data: data!, encoding: .utf8))")
                    completion(.success(data))
                case .failure(let error):
                    print("Error: failure to create user no data \(error)")
                    completion(.failure(.invalidCredentials))
                }
            }
    }

    static func makeRequest(
        urlString: String,
        httpMethod: HTTPMethod,
        requestBody: [String : Any],
        completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void
    ) {
        let url = URL(string: urlString)

        guard let url = url else { return }

        var request = URLRequest(url: url)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch let error {
            print("ERROR: error adding request body \(error)")
        }

        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("ERROR: error with url requst \(error)")
                return
            }

            guard let data = data else {
                print("TESTING: data missing")
                completion(.failure(.noData))
                return
            }

            completion(.success(data))

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    print(json)
                }
            } catch let error {
                print("Error: Error with serialization \(error)")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }

    static func makePostRequest(
        userId: String,
        urlString: String,
        httpMethod: HTTPMethod,
        requestBody: [String : Any],
        completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void
    ) {
        let url = URL(string: urlString)

        guard let url = url else { return }

        var request = URLRequest(url: url)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch let error {
            print(error)
        }

        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        request.addValue("\(userId)", forHTTPHeaderField: "user_id")
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            completion(.success(data))

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    print(json)
                }
            } catch _ {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
