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
    let title = "Settings"
    func items(at index: Int) -> SettingsItemViewModel {
        itemViewModel[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModel[index].type {
        case .mode:
            // Toggle light and Dark
        isDarkMode = !isDarkMode
            buildItems()
        default:
            break
        }
    }
    
    private func buildItems() {
        itemViewModel = [.init(title: "Create an Account", name: "person.circle", type: .account), .init(title: "Toggle \(isDarkMode ? "Light" : "Dark") Mode", name: "lightbulb", type: .mode), .init(title: "Privacy Terms", name: "shield", type: .privacy)]
    }
    
    func onSet() {
       buildItems()
    }
    
}
