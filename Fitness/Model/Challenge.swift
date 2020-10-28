//
//  Challenge.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
struct Challenge: Codable, Hashable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
}
