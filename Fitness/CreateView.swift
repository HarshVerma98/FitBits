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
//        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
//            DropdownView(viewModel: $viewModel.dropdowns[index])
//        }
        Group {
            DropdownView(viewModel: $viewModel.exerciseDropDown)
            DropdownView(viewModel: $viewModel.startAmountDropDown)
            DropdownView(viewModel: $viewModel.increaseDropDown)
            DropdownView(viewModel: $viewModel.lengthDropDown)
        }
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
            
            .navigationBarTitle("Create")
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 15)
        }
    }
}
