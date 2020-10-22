//
//  UserService.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
import Combine
import FirebaseAuth
protocol UserServiceProtocol {
    func currentUser() -> AnyPublisher<User?, Never>
    func signInAnonymously() -> AnyPublisher<User, FitnessCustomError>
}


final class UserService: UserServiceProtocol {
    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<User, FitnessCustomError> {
        return Future<User, FitnessCustomError> { promise in
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    return promise(.failure(.auth(description: error.localizedDescription)))
                }else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
}
