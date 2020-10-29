//
//  SettingsViewModel.swift
//  Fitness
//
//  Created by Harsh Verma on 28/10/20.
//

import Foundation
import Combine
import SwiftUI
final class SettingsViewModel: ObservableObject {
    @Published private(set) var itemViewModel: [SettingsItemViewModel] = []
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published var loginSignup = false
    let title = "Settings"
    private let userService: UserServiceProtocol
    private var cancellable: [AnyCancellable] = []
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func items(at index: Int) -> SettingsItemViewModel {
        itemViewModel[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModel[index].type {
        case .account:
            guard userService.currentUser?.email == nil else {return }
            loginSignup = true
        case .mode:
            // Toggle light and Dark
            isDarkMode = !isDarkMode
            buildItems()
        case .logout:
            print("Logged out the User")
            userService.logout().sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { (_) in}
            .store(in: &cancellable)
            
        default:
            break
        }
        
    }
    private func buildItems() {
        itemViewModel = [.init(title: userService.currentUser?.email ?? "Create an Account", name: "person.circle", type: .account), .init(title: "Toggle \(isDarkMode ? "Light" : "Dark") Mode", name: "lightbulb", type: .mode), .init(title: "Privacy Terms", name: "shield", type: .privacy)]
        
        if userService.currentUser?.email != nil {
            itemViewModel += [.init(title: "Logout", name: "arrowshape.turn.up.left", type: .logout)]
        }
    }
    
    func onSet() {
        buildItems()
    }
    
}
