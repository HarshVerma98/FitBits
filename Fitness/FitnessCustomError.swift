//
//  FitnessCustomError.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
enum FitnessCustomError: LocalizedError {
    case auth(description: String)
    case `default` (description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let .default(description):
            return description ?? "Something Unexpected Happened"
        }
    }
}
