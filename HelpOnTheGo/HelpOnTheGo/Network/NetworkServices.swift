//
//  AuthServices.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation

class NetworkServices {

    init() {}
    
    static func getAllPosts(completion: @escaping (_ result: Result<[PostModel], AuthError>) -> Void) {
        let url = URL(string: "http://localhost:5001/api/posts")

        guard let url = url else { return }

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

            // set the body of the request
            do {
                let response = try JSONDecoder().decode([PostModel].self, from: data)
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
                    print("TESTING: success logged in")
                    completion(.success(data))
                case .failure(_):
                    print("TESTING: failure making request")
                    completion(.failure(.invalidCredentials))
                }
            }
    }
    
    static func uploadPost(
        postItem: PostItem,
        completion: @escaping (_ result: Result<Data?, AuthError>) -> Void
    ) {

        makeRequest(
            urlString: "http://localhost:5001/api/posts",
            httpMethod: .post,
            requestBody: ["text" : postItem.bodyText, "motive" : postItem.helpState]
        ) { result in
                switch result {
                case .success(let data):
                    print("TESTING: Success data uploaded")
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
                    completion(.success(data))
                case .failure(_):
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
            print(error)
        }

        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("TESTING: error with data \(error)")
                return
            }

            guard let data = data else {
                print("TESTING: data missing \(data)")
                completion(.failure(.noData))
                return
            }

            completion(.success(data))

            // set the body of the request
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    print(json)
                }
            } catch let error {
                print("TESTING: Error with serialization")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
