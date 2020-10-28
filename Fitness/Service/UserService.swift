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
    func observeAuthChanges() -> AnyPublisher<User?, Never>
    func linkAccount(email: String, password: String) -> AnyPublisher<Void, FitnessCustomError>
}


final class UserService: UserServiceProtocol {
    func linkAccount(email: String, password: String) -> AnyPublisher<Void, FitnessCustomError> {
        let emailCredit = EmailAuthProvider.credential(withEmail: email, password: password)
        return Future<Void, FitnessCustomError> { promise in
            Auth.auth().currentUser?.link(with: emailCredit) { result, error in
                if let error = error {
                    return promise(.failure(.default(description: error.localizedDescription)))
                }else if let user = result?.user {
                    Auth.auth().updateCurrentUser(user) { error in
                        if let error = error {
                            return promise(.failure(.default(description: error.localizedDescription)))
                        }else {
                            promise(.success(()))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
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
    
    func observeAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPubs().eraseToAnyPublisher()
    }
}
