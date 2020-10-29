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
    private var isComplete: Bool {
        daysFromStart - challenge.length >= 0
    }
    
    private let onDelete: (String) -> Void
    
    var statusText: String {
        guard !isComplete else {return "Done"}
        let dayNumber = daysFromStart + 1
        return "Day \(dayNumber) of \(challenge.length)"
    }
    var dailyIncrement: String {
        "+\(challenge.length) Daily"
    }
    init(_ challenge: Challenge, onDelete: @escaping(String) -> Void) {
        self.challenge = challenge
        self.onDelete = onDelete
    }
    
   
    
    func tappedDelete() {
        onDelete(id)
    }
}
