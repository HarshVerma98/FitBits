//
//  Challenge.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
import FirebaseFirestoreSwift
struct Challenge: Codable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
    @DocumentID var id: String?
    let activities: [Activity]
}

struct Activity: Codable {
    let date: Date
    let isComplete: Bool
}
