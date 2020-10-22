//
//  ChallengeListView.swift
//  Fitness
//
//  Created by Harsh Verma on 22/10/20.
//

import Foundation
import SwiftUI

struct ChallengeListView: View {
    @StateObject private var viewModel = ChallengeListViewModel()
    var body: some View {
        Text("Challenge list!")
    }
}
