//
//  ProgressView.swift
//  Fitness
//
//  Created by Harsh Verma on 29/10/20.
//
import SwiftUI
struct ProgressCircleView: View {
    let viewModel: ProgressViewModel
    @State private var percent: CGFloat = 0
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .fill(Color.outline)
            Circle()
                .trim(from: 0, to: CGFloat(viewModel.percentComplete))
                .stroke(style: .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .fill(Color.GreenTrack)
                .rotationEffect(.init(degrees: -90))
            VStack {
                if viewModel.showTitle {
                    Text(viewModel.title)
                    
                }
                Text(viewModel.message)
            }.padding(25)
            .font(Font.caption.weight(.semibold))
        }.onAppear {
            withAnimation(.spring(response: 4)) {
                percent = CGFloat(viewModel.percentComplete)
            }
        }
    }
}
