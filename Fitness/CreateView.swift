//
//  CreateView.swift
//  Fitness
//
//  Created by Harsh Verma on 18/10/20.
//

import SwiftUI

struct CreateView: View{
    @State private var isActive = false
    var body: some View {
        ScrollView {
            VStack {
                DropdownView()
                DropdownView()
                DropdownView()
                DropdownView()
                Spacer()
                NavigationLink(destination: RemindView(), isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Next")
                            .font(.system(size: 24, weight: .medium))
                    }
                }.navigationBarTitle("Create")
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}
