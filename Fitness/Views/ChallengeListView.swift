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
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            }else if let error = viewModel.error {
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry Again") {
                        viewModel.send(action: .retry)
                    }
                    .padding(10)
                    .background(Rectangle().fill(Color.red).cornerRadius(6))
                }
            }else {
                mainContentView
            }
        }
    }
    var mainContentView: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible(), spacing: 20), .init(.flexible())], spacing: 20) {
                    ForEach(viewModel.itemViewModel, id: \.self) {viewModel in
                        
                        ChallengeItemView(viewModel: viewModel)
                        
                    }
                }
                Spacer()
            }.padding(10)
        }
        .sheet(isPresented: $viewModel.modalCreation) {
            NavigationView {
            CreateView()
        }
        }
        .navigationBarItems(trailing: Button {
            viewModel.send(action: .create)
        } label: {
            Image(systemName: "plus.circle").imageScale(.large)
        })
        .navigationTitle(viewModel.title)
    }
}
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
            Image(systemName: "trash")
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
                Text(viewModel.statusText)
                    .font(.system(size: 12, weight: .bold))
                    .padding(25)
                dailyIncreaseRows
            }.padding(.vertical,10)
            Spacer()
        }
        .background(Rectangle().fill(Color.darkPrimaryButton).cornerRadius(7))
    }
}
