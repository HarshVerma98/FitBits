//
//  TabView.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import SwiftUI
struct TabViewContainer: View {
    @StateObject private var tabContainerModel = TabViewModel()
    var body: some View {
        TabView(selection: $tabContainerModel.selectedTab) {
            ForEach(tabContainerModel.items, id: \.self) { viewModel in
                tabView(for: viewModel.type)
                    .tabItem {
                        Image(systemName: viewModel.imageName)
                        Text(viewModel.title)
                    }.tag(viewModel.type)
            }
        }.accentColor(.primary)
    }
    @ViewBuilder
    func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
        case .log:
            Text("Log")
        case .challengeList:
            NavigationView {
                ChallengeListView()
            }
        case .settings:
            NavigationView {
                Settings()
            }
        }
    }
    
}

final class TabViewModel: ObservableObject {
    
    @Published var selectedTab: TabItemViewModel.TabItemType = .challengeList
    
    
    let items = [TabItemViewModel(imageName: "book", title: "Activity Logs", type: .log), .init(imageName: "list.bullet", title: "Challenges", type: .challengeList), .init(imageName: "gear", title: "Setting", type: .settings)]
}


struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    
    enum TabItemType {
        case log
        case challengeList
        case settings
    }
}
