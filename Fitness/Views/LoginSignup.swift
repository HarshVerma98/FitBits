//
//  LoginSignup.swift
//  Fitness
//
//  Created by Harsh Verma on 28/10/20.
//

import SwiftUI
struct LoginSignup: View {
    @ObservedObject var viewModel: LSViewModel
    
    var emailTextField: some View {
        TextField("Email", text: $viewModel.emailText).modifier(TFRounded())
    }
    
    var passwordTextField: some View {
        SecureField("Password", text: $viewModel.passwordText).modifier(TFRounded())
    }
    
    var actionButton: some View {
        Button(viewModel.buttonTitle) {
            
        }.padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color(.systemGreen))
        .cornerRadius(17)
        .padding()
    }
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(viewModel.subtitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray3))
            Spacer().frame(height: 50)
            emailTextField
            passwordTextField
            actionButton
            Spacer()
        }.padding()
    }
}
