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
    
    var mVC: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                
                Button(action: {
                    viewModel.send(action: .createChallenge)
                }) {
                    Text("Create")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.primary)
                }
                
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            if viewModel.isLoader {
                ProgressView()
            }else {
                mVC
            }
        }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
            Alert(title: Text("Error!"), message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""), dismissButton: .default(Text("OK"), action: {
                viewModel.error = nil
            }))
        }
        .navigationBarTitle("Create")
        .navigationBarBackButtonHidden(true)
        .padding(15)
    }
}
