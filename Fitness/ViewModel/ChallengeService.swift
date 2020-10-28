//
//  ChallengeService.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
protocol ChallengeServiceProtocol {
    func create(_ challenge: Challenge) -> AnyPublisher<Void, FitnessCustomError>
    func observeChallenges(userId: UserId) -> AnyPublisher<[Challenge], FitnessCustomError>
}

final class ChallengeService: ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    func create(_ challenge: Challenge) -> AnyPublisher<Void, FitnessCustomError> {
        return Future<Void, FitnessCustomError> { promise in
            do {
                _ = try self.db.collection("Challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure(.default(description: error.localizedDescription)))
                    }else {
                        promise(.success(()))
                    }
                }
                promise(.success(()))
            }catch {
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }
    func observeChallenges(userId: UserId) -> AnyPublisher<[Challenge], FitnessCustomError> {
        let query = db.collection("Challenges").whereField("userId", isEqualTo: userId)
        return Publishers.QueryPublisher(query: query).flatMap { snapshot -> AnyPublisher<[Challenge], FitnessCustomError> in
            do {
                let challenge = try snapshot.documents.compactMap {
                    try $0.data(as: Challenge.self)
                }
                return Just(challenge).setFailureType(to: FitnessCustomError.self).eraseToAnyPublisher()
            }catch {
                return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
            }
            
        }.eraseToAnyPublisher()
    }
}
