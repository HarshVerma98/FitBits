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
        
        Publishers.CombineLatest($emailText, $passwordText).map { [weak self]email, password in
            // Authenticity Check goes here
            return self?.isValidEmail(email) == true && self?.isValidPassword(password) == true
        }.assign(to: &$isValid)
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
            userService.login(email: emailText, password: passwordText).sink { (completion) in
                switch completion {
                case let .failure(error):
                    print("Error at Line 50 of LSViewModel Swift File \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { (_) in}
            .store(in: &cancellable)
            
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

extension LSViewModel {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) && email.count > 5
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 5
    }
}
