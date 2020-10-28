//
//  LandingViewModel.swift
//  Fitness
//
//  Created by Harsh Verma on 28/10/20.
//

import Foundation
import SwiftUI
import Combine

final class LandingViewModel: ObservableObject {
    @Published var loginSignup = false
    @Published var create = false
    let title = "Fitness"
    let createButtonTitle = "Create Exercise"
    let createButtonImage = "plus.circle"
    let alreadyButtonTitle = "Existing Account"
    let backgroundImageName = "main"
}

