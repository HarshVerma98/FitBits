//
//  TFRounded.swift
//  Fitness
//
//  Created by Harsh Verma on 28/10/20.
//

import Foundation
import SwiftUI
struct TFRounded: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Color(.systemGray3))
            .padding()
            .cornerRadius(17)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 17
                ).stroke(Color.primary
            ))
            .padding(.horizontal,15)
    }
}
