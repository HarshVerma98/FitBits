//
//  ChallengeListViewModel.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
import Combine
final class ChallengeListViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellable: [AnyCancellable] = []
    
    init(userService: UserServiceProtocol = UserService(), challengeService: ChallengeServiceProtocol = ChallengeService()) {
        self.challengeService = challengeService
        self.userService = userService
        observeChallenges()
    }
    
    private func observeChallenges() {
        userService.currentUser().compactMap {
            $0?.uid}.flatMap { userId -> AnyPublisher<[Challenge], FitnessCustomError> in
                return self.challengeService.observeChallenges(userId: userId)
            }.sink { (completion) in
                switch completion {
                case let .failure(error):
                    print("Error:- \(error.localizedDescription)")
                case .finished:
                    print("Completed")
                }
            } receiveValue: { (challenges) in
                print(challenges)
            }.store(in: &cancellable)

    }
    
}
