//
//  ChallengeListView.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
import SwiftUI

struct ChallengeListView: View {
    @StateObject private var viewModel = ChallengeListViewModel()
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                    ForEach(viewModel.itemViewModel, id: \.self) {viewModel in
                        
                        ChallengeItemView(viewModel: viewModel)
                        
                    }
                }
                Spacer()
            }
        }.navigationTitle(viewModel.title)
    }
}
struct ChallengeItemView: View {
    private let viewModel: ChallengeItemViewModel
    init(viewModel: ChallengeItemViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(viewModel.title).font(.system(size: 24, weight: .bold))
                Text(viewModel.statusText)
                Text(viewModel.dailyIncrement)
            }.padding()
            Spacer()
        }
        .background(Rectangle().fill(Color.darkPrimaryButton).cornerRadius(7).padding())
    }
}
