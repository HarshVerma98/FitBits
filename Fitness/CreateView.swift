//
//  CreateView.swift
//  Fitness
//
//  Created by Harsh Verma on 18/10/20.
//

import SwiftUI

struct CreateView: View{
    @StateObject var viewModel = CreateChallengeViewModel()
    
    var dropdownList: some View {
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropdownView(viewModel: $viewModel.dropdowns[index])
        }
    }
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select"), buttons: viewModel.displayOptions.indices.map { index in
            let option = viewModel.displayOptions[index]
            return ActionSheet.Button.default(Text(option.formatted)) {
                viewModel.send(action: .selectedOption(index: index))
            }
        })
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                
                    Button(action: {
                        viewModel.send(action: .createChallenge)
                    }) {
                        Text("Create")
                            .font(.system(size: 24, weight: .medium))
                    }
                
            }
            .actionSheet(isPresented: Binding<Bool>(
                get: {
                viewModel.hasSelectedDropdown
            }, set: {_ in})
            ) {
                actionSheet
            }
            .navigationBarTitle("Create")
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 15)
        }
    }
}
