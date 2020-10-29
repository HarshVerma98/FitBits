//
//  ChallengeItemView.swift
//  Fitness
//
//  Created by Harsh Verma on 29/10/20.
//

import SwiftUI
struct ChallengeItemView: View {
    private let viewModel: ChallengeItemViewModel
    init(viewModel: ChallengeItemViewModel) {
        self.viewModel = viewModel
    }
    
    var titleRow: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Image(systemName: "trash").onTapGesture {
                viewModel.tappedDelete()
            }
        }
    }
    
    var dailyIncreaseRows: some View {
        HStack {
            Text(viewModel.dailyIncrement)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                titleRow
                ProgressCircleView(viewModel: viewModel.progressCircleViewModel).padding(.vertical, 25)
                dailyIncreaseRows
            }.padding(.vertical,10)
            Spacer()
        }
        .background(Rectangle().fill(Color.darkPrimaryButton).cornerRadius(7))
    }
}
