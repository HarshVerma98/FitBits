//
//  LSViewModel.swift
//  Fitness
//
//  Created by Harsh Verma on 28/10/20.
//

import Foundation
import Combine
final class LSViewModel: ObservableObject {
    private let mode: Mode
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    init(mode: Mode) {
        self.mode = mode
    }
    
    var title: String {
        switch mode {
        case .login:
            return "Welcome back"
        case .signup:
            return "Create an Account"
        }
    }
    
    var subtitle: String {
        switch mode {
        case .login:
            return "Login with Email"
        case .signup:
            return "Signup with Email"
        }
    }
    
    var buttonTitle: String {
        switch mode {
        case .login:
            return "Log In"
        case .signup:
            return "Sign Up"
        }
    }
}

extension LSViewModel {
    enum Mode {
        case login
        case signup
    }
}
