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
    @Published private(set) var error: FitnessCustomError?
    @Published private(set) var isLoading = false
    @Published private(set) var itemViewModel: [ChallengeItemViewModel] = []
    let title = "Challenges"
    
    enum Action {
        case retry
    }
    
    init(userService: UserServiceProtocol = UserService(), challengeService: ChallengeServiceProtocol = ChallengeService()) {
        self.challengeService = challengeService
        self.userService = userService
        observeChallenges()
    }
    
    
    func send(action: Action) {
        switch action {
        case .retry:
            observeChallenges()
        }
    }
    
    private func observeChallenges() {
        isLoading = true
        userService.currentUser().compactMap {
            $0?.uid}.flatMap { [weak self]userId -> AnyPublisher<[Challenge], FitnessCustomError> in
                guard let self = self else {return Fail(error: .default()).eraseToAnyPublisher()}
                return self.challengeService.observeChallenges(userId: userId)
            }.sink { [weak self](completion) in
                guard let self = self else {return }
                self.isLoading = false
                switch completion {
                case let .failure(error):
                    self.error = error
                    print("Error:- \(error.localizedDescription)")
                case .finished:
                    print("Completed")
                }
            } receiveValue: { [weak self](challenges) in
                //print(challenges)
                guard let self = self else {return}
                self.isLoading = false
                self.error = nil
                self.itemViewModel = challenges.map { .init($0)}
            }.store(in: &cancellable)

    }
    
}
