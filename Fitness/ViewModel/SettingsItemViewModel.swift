//
//  SettingsItemViewModel.swift
//  Fitness
//
//  Created by Harsh Verma on 28/10/20.
//

import Foundation
extension SettingsViewModel {
    struct SettingsItemViewModel {
        let title: String
        let name: String
        let type: SettingItemType
    }
    
    enum SettingItemType {
        case account
        case mode
        case privacy
    }
}
