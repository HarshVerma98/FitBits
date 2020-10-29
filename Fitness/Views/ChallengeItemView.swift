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
                viewModel.send(action: .delete)
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
    
    var nowView: some View {
        Group {
            Divider()
            Text(viewModel.nowTitle)
                .font(.title3)
                .fontWeight(.medium)
            Text(viewModel.RepTitle)
                .font(.system(size: 24, weight: .bold))
            
            Button(viewModel.isDayComplete || viewModel.isComplete ? "Completed" : "Mark as Done") {
                viewModel.send(action: .toggleComplete)
            }.disabled(viewModel.isComplete)
            .padding(.vertical,10)
            .padding(.horizontal,15)
            .font(Font.caption.weight(.semibold))
            .background(viewModel.isDayComplete ? Color.GreenTrack : Color.primaryBtton)
            .cornerRadius(8)
        }
    }
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 25) {
                titleRow
                ProgressCircleView(viewModel: viewModel.progressCircleViewModel)
                dailyIncreaseRows
                    nowView
            }.padding(.vertical,10)
            Spacer()
        }
        .background(Rectangle().fill(Color.darkPrimaryButton).cornerRadius(7))
    }
}
