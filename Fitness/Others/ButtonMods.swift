//
//  ButtonMods.swift
//  Fitness
//
//  Created by Harsh on 19/09/20.
//

import Foundation
import SwiftUI

struct ButtonMods: ButtonStyle {
    var fillColor: Color = .darkPrimaryButton
    func makeBody(configuration: Configuration) -> some View {
        return ButtonMod(configuration: configuration, fillColor: fillColor)
    }
    
    struct ButtonMod: View {
        let configuration: Configuration
        let fillColor: Color
        var body: some View {
            return configuration.label.padding(20).background(RoundedRectangle(cornerRadius: 8.0).fill(fillColor))
        }
    }
}
    
    struct ButtonMods_Preview: PreviewProvider {
        static var previews: some View {
            Button(action: {}, label: {
                Text("Create a Challenge")
            }).buttonStyle(ButtonMods())
        }
    }

