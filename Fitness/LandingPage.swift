//
//  ContentView.swift
//  Fitness
//
//  Created by Harsh on 19/09/20.
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer().frame(height: proxy.size.height * 0.18)
                Text("Fitness").font(.system(size: 64, weight: .medium)).foregroundColor(.white)
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus.circle").font(.system(size: 24, weight: .semibold)).foregroundColor(.white)
                        Text("Create Challenge").font(.system(size: 24, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        
                    }
                }
                ).padding(.horizontal, 15).buttonStyle(ButtonMods())
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("main").resizable().aspectRatio(contentMode: .fill).overlay(Color.black.opacity(0.4)).frame(width: proxy.size.width).edgesIgnoringSafeArea(.all))
        }
        
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage().previewDevice("iPhone SE")
        LandingPage().previewDevice("iPhone XS")
    }
}
