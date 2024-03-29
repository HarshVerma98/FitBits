//
//  ChallengeItemViewModel.swift
//  Fitness
//
//  Created by Harsh Verma on 23/10/20.
//

import Foundation
struct ChallengeItemViewModel: Identifiable {
    private let challenge: Challenge
    
    var id: String {
        challenge.id ?? ""
    }
    
    var title: String {
        challenge.exercise.capitalized
    }
    
    var progressCircleViewModel: ProgressViewModel {
        let dayNumber = daysFromStart + 1
        let title = "Day"
        let message = isComplete ? "Done" : "\(dayNumber) of \(challenge.length)"
        return .init(title: title, message: message, percentComplete: Double(dayNumber) / Double(challenge.length))
    }
    
    private var daysFromStart: Int {
        let startDate = Calendar.current.startOfDay(for: challenge.startDate)
        let toDate = Calendar.current.startOfDay(for: Date())
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: startDate, to: toDate).day else {
            return 0
        }
        return abs(daysFromStart)
    }
     var isComplete: Bool {
        daysFromStart - challenge.length >= 0
    }
    
    private let onDelete: (String) -> Void
    private let onToggleComplete: (String, [Activity]) -> Void
    let nowTitle = "Today"
    
    var RepTitle: String {
        let repNumber = challenge.startAmount + (daysFromStart * challenge.increase)
        let exercise: String
        if repNumber == 1 {
            var challengeExercise = challenge.exercise
            challengeExercise.removeLast()
            exercise = challengeExercise
        }else {
            exercise = challenge.exercise
        }
        return isComplete ? "Done" : "\(repNumber) " + exercise
    }
    
    var shouldShow: Bool {
        !isComplete
    }
    
    var isDayComplete: Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return challenge.activities.first(where: {$0.date == today})?.isComplete == true
    }
    
    var statusText: String {
        guard !isComplete else {return "Done"}
        let dayNumber = daysFromStart + 1
        return "Day \(dayNumber) of \(challenge.length)"
    }
    var dailyIncrement: String {
        "+\(challenge.length) Daily"
    }
    init(_ challenge: Challenge, onDelete: @escaping(String) -> Void, onToggleComplete: @escaping(String, [Activity]) -> Void) {
        self.challenge = challenge
        self.onDelete = onDelete
        self.onToggleComplete = onToggleComplete
    }
    
   
    
    
    func send(action: Action) {
        guard let id = challenge.id else {return}
        switch action {
        case .delete:
            onDelete(id)
        case .toggleComplete:
            let today = Calendar.current.startOfDay(for: Date())
            let activities = challenge.activities.map { activity -> Activity in
                if today == activity.date {
                    return .init(date: today, isComplete: !activity.isComplete)
                }else {
                    return activity
                }
            }
            onToggleComplete(id, activities)
        }
    }
    
}
extension ChallengeItemViewModel {
    enum Action {
        case delete
        case toggleComplete
    }
}
