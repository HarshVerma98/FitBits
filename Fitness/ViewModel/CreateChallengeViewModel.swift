//
//  CreateViewViewModel.swift
//  Fitness
//
//  Created by Harsh Verma on 18/10/20.
//
import SwiftUI
import Combine

typealias UserId = String
final class CreateChallengeViewModel: ObservableObject {
    //    @Published var dropdowns: [ChallengePartViewModel] = [
    //        .init(type: .exercise), .init(type: .startAmount), .init(type: .increase), .init(type: .length)]
    //
    @Published var exerciseDropDown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropDown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropDown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropDown = ChallengePartViewModel(type: .length)
    @Published var error: FitnessCustomError?
    @Published var isLoader = false
    
    private let userService: UserServiceProtocol
    private var cancellable: [AnyCancellable] = []
    private let challengeService: ChallengeServiceProtocol
    
    enum Action {
        case createChallenge
    }
    
    
    init(userService: UserServiceProtocol = UserService(), challengeService: ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
        case .createChallenge:
            isLoader = true
            print("Created Successfully")
            currentUser().flatMap { userId -> AnyPublisher<Void, FitnessCustomError> in
                return self.createChallenge(userId: userId)
            }
            .sink { (done) in
                self.isLoader = false
                switch done {
                case let .failure(error):
                    self.error = error
                    print(error.localizedDescription)
                case .finished:
                    print("Done in")
                }
            } receiveValue: { (_) in
                print("$ucceeded")
            }.store(in: &cancellable)
        //
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, FitnessCustomError> {
        guard let exercise = exerciseDropDown.text,
              let startAmount = startAmountDropDown.number,
              let increase = increaseDropDown.number,
              let length = lengthDropDown.number else {
            return Fail(error: .default(description: "Parsing Error")).eraseToAnyPublisher()
        }

        let startDate = Calendar.current.startOfDay(for: Date())

        let challenge = Challenge(exercise: exercise, startAmount: startAmount, increase: increase, length: length, userId: userId, startDate: startDate, activities: (0..<length).compactMap { dayNumber in
            if let dateFor = Calendar.current.date(byAdding: .day, value: dayNumber, to: startDate) {
                return .init(date: dateFor, isComplete: false)
            }else {
                return nil
            }
        }
                                  
        )
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    
    
    private func currentUser() -> AnyPublisher<UserId, FitnessCustomError> {
        return userService.currentUserPublisher().flatMap { user -> AnyPublisher<UserId, FitnessCustomError> in
           //return Fail(error: .auth(description: "FIREBASE FAULT")).eraseToAnyPublisher()
                        if let user = user?.uid {
                return Just(user)
                    .setFailureType(to: FitnessCustomError.self)
                    .eraseToAnyPublisher()
            }else {
                return self.userService.signInAnonymously().map {$0.uid}.eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
    
}

extension CreateChallengeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
        }
        
        var isSelected: Bool = false
        private let type: ChallengePartType
        init(type: ChallengePartType) {
            
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map{ $0.toDropdownOption}
            case .startAmount:
                self.options = StartOption.allCases.map{$0.toDropdownOption}
            case .increase:
                self.options = IncreaseOption.allCases.map{$0.toDropdownOption}
            case .length:
                self.options = LengthOption.allCases.map{$0.toDropdownOption}
            }
            self.type = type
            self.selectedOption = options.first!
        }
        
        
        
        // MARK:- CUSTOM ENUMS
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        // Exercise Choice Enum
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue), formatted: rawValue.capitalized, isSelected: self == .pullups)
            }
        }
        
        // Start Enum
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue)", isSelected: self == .one)
            }
        }
        
        // Increase Enum
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue)", isSelected: self == .one)
            }
        }
        
        // Length Enum
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue) Days", isSelected: self == .seven)
            }
        }
        
        
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
