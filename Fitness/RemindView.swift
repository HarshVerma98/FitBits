//
//  RemindView.swift
//  Fitness
//
//  Created by Harsh Verma on 18/10/20.
//

import SwiftUI

struct RemindView: View {
    var body: some View {
        VStack {
            Spacer()
            //DropdownView()
            Spacer()
            Button(action: {}) {
                Text("Create")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }.padding(.bottom, 15)
            Button(action: {}) {
                Text("Skip")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }
        }.navigationTitle("Remind Me")
        .padding(.bottom, 15)
    }
}


//struct RemindView_previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            RemindView()
//        }
//    }
//}
