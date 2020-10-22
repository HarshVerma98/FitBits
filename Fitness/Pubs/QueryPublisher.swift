//
//  QueryPublisher.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
import Combine
import Firebase
extension Publishers {
    struct QueryPublisher: Publisher {
        typealias Output = QuerySnapshot
        typealias Failure = FitnessCustomError
        private let query: Query
        
        init(query: Query) {
            self.query = query
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let querySnapshotSubscription = QuerySnapshotSubscription(subscriber: subscriber, query: query)
            subscriber.receive(subscription: querySnapshotSubscription)
        }
        
    }
    
    class QuerySnapshotSubscription<S: Subscriber>: Subscription where S.Input == QuerySnapshot, S.Failure == FitnessCustomError {
        
        private var subscriber: S?
        private var listener: ListenerRegistration?
        
        init(subscriber: S, query: Query) {
            listener = query.addSnapshotListener({ (query, error) in
                if let error = error {
                   subscriber.receive(completion: .failure(.default(description: error.localizedDescription)))
                }else if let querySnap = query {
                    _ = subscriber.receive(querySnap)
                }else {
                    subscriber.receive(completion: .failure(.default(description: "ERROR101")))
                }
            })
        }
        
        func request(_ demand: Subscribers.Demand) {
            
        }
        
        func cancel() {
            subscriber = nil
            listener = nil
        }
        
        
    }
}
