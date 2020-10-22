//
//  AuthPubs.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
import Combine
import FirebaseAuth
extension Publishers {
    struct AuthPubs: Publisher {
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let authSubs = AuthSubscription(subscriber: subscriber)
            subscriber.receive(subscription: authSubs)
        }
        
        typealias Output = User?
        typealias Failure = Never
    }
    
    
    class AuthSubscription<S: Subscriber>: Subscription where S.Input == User?, S.Failure == Never {
        
        private var subscriber: S?
        private var handler: FirebaseAuth.AuthStateDidChangeListenerHandle?
        init(subscriber: S) {
            self.subscriber = subscriber
            handler = Auth.auth().addStateDidChangeListener({ (auth, user) in
                _ = subscriber.receive(user)
            })
        }
        
        func request(_ demand: Subscribers.Demand) {
            
        }
        
        func cancel() {
            subscriber = nil
            handler = nil
        }
    }
}
