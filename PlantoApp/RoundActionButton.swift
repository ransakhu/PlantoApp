//
//  RoundActionButton.swift
//  PlantoApp
//
//  Created by rand on 28/10/2025.
//

import SwiftUI
import SwiftUI

struct RoundActionButton: View {
    let systemName: String
    let foreground: Color
    let background: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(foreground)
                .frame(width: 32, height: 32)
                .background(Circle().fill(background))
        }
        .buttonStyle(.plain)
    }
}
