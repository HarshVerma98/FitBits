//
//  DropdownView.swift
//  Fitness
//
//  Created by Harsh Verma on 18/10/20.
//

import SwiftUI

struct DropdownView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Exercise")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.vertical, 10)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Text("Pushups")
                        .font(.system(size: 29, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                }
            }).buttonStyle(ButtonMods(fillColor: .primaryBtton))
        }.padding(20)
    }
}


struct DropdownView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DropdownView()
        }
        NavigationView {
            DropdownView()
        }.environment(\.colorScheme, .dark)
    }
}
