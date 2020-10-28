//
//  DropdownView.swift
//  Fitness
//
//  Created by Harsh Verma on 18/10/20.
//

import SwiftUI

struct DropdownView<T: DropdownItemProtocol>: View {
    @Binding var viewModel: T
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select"), buttons: viewModel.options.map { option in
            return ActionSheet.Button.default(Text(option.formatted)) {
                viewModel.selectedOption = option
            }
        })
    }
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.vertical, 10)
            Button(action: {
                viewModel.isSelected = true
            }, label: {
                HStack {
                    Text(viewModel.dropdownTitle)
                        .font(.system(size: 29, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                }
            }).buttonStyle(ButtonMods(fillColor: .primaryBtton))
        }.actionSheet(isPresented: $viewModel.isSelected)
                     {
                        actionSheet
                    }
        .padding(15)
    }
}
