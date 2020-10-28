//
//  LSViewModel.swift
//  Fitness
//
//  Created by Harsh Verma on 28/10/20.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth
final class LSViewModel: ObservableObject {
    private let mode: Mode
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    @Binding var isPushed: Bool
    private let userService: UserServiceProtocol
    private var cancellable: [AnyCancellable] = []
    init(mode: Mode, userService: UserServiceProtocol = UserService(), isPushed: Binding<Bool>) {
        self.mode = mode
        self.userService = userService
        self._isPushed = isPushed
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
    
    func tappedAction() {
        switch mode {
        case .login:
            print("Logged In")
        case .signup:
            // Account Linking Here
            userService.linkAccount(email: emailText, password: passwordText).sink { [weak self]completion in
                guard let self = self else {return}
                switch completion {
                case let .failure(error):
                    print("Error at LSViewModel: \(error.localizedDescription)")
                case .finished:
                    print("Hurray!!")
                    self.isPushed = false
                }
            } receiveValue: { (_) in }
            .store(in: &cancellable)
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
