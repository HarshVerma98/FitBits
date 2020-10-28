//
//  Settings.swift
//  Fitness
//
//  Created by Harsh Verma on 28/10/20.
//

import SwiftUI

struct Settings: View {
    @StateObject private var viewModel = SettingsViewModel()
    var body: some View {
        List(viewModel.itemViewModel.indices, id: \.self) { index in
            Button {
                viewModel.tappedItem(at: index)
            } label:  {
                HStack {
                    Image(systemName: viewModel.items(at: index).name)
                    Text(viewModel.items(at: index).title)
                }
            }
        }
        .navigationTitle(viewModel.title)
        .onAppear {
            viewModel.onSet()
        }
    }
}
