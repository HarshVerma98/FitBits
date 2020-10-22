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
    func create(_ challenge: Challenge) -> AnyPublisher<Void, Error>
}

final class ChallengeService: ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    func create(_ challenge: Challenge) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                _ = try self.db.collection("Challenges").addDocument(from: challenge)
                promise(.success(()))
            }catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
}
