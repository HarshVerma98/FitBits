//
//  ProgressViewModel.swift
//  Fitness
//
//  Created by Harsh Verma on 29/10/20.
//

import Foundation

struct ProgressViewModel {
    let title: String
    let message: String
    let percentComplete: Double
    var showTitle: Bool {
        percentComplete <= 1
    }
}
