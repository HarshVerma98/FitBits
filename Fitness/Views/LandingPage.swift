//
//  ContentView.swift
//  Fitness
//
//  Created by Harsh on 19/09/20.
//

import SwiftUI

struct LandingPage: View {
    @StateObject private var viewModel = LandingViewModel()
    
    var title: some View {
        Text(viewModel.title).font(.system(size: 64, weight: .medium)).foregroundColor(.white)
    }
    
    var createButton: some View {
        Button(action: {
            viewModel.create = true
        }, label: {
            HStack {
                Spacer()
                Image(viewModel.createButtonImage).font(.system(size: 24, weight: .semibold)).foregroundColor(.white)
                Text(viewModel.createButtonTitle).font(.system(size: 24, weight: .semibold)).foregroundColor(.white)
                Spacer()
                
            }
        }
        ).padding(.horizontal,15).padding(.horizontal, 15).buttonStyle(ButtonMods())
        
    }
    
    var latter: some View {
        Button(viewModel.alreadyButtonTitle) {
            viewModel.loginSignup = true
        }.foregroundColor(.white)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.18)
                    title
                    Spacer()
                    NavigationLink(destination: CreateView(), isActive: $viewModel.create) {}
                        createButton
                        NavigationLink(destination: LoginSignup(viewModel: .init(mode: .login))
                                       , isActive: $viewModel.loginSignup) {
                            
                        }
                        latter
                    }.padding(.bottom, 15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image(viewModel.backgroundImageName).resizable().aspectRatio(contentMode: .fill).overlay(Color.black.opacity(0.4)).frame(width: proxy.size.width).edgesIgnoringSafeArea(.all))
                }
                
            }.accentColor(.primary)
        }
    }

