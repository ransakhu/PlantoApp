//
//  WaterToggleCircle.swift
//  PlantoApp
//
//  Created by rand on 28/10/2025.
//
import SwiftUI

struct WaterToggleCircle: View {
    let isFilled: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(isFilled ? Color.greens : Color.clear)
                .frame(width: 36, height: 36)
            
            Circle()
                .strokeBorder(isFilled ? Color.greens : Color.white.opacity(0.6), lineWidth: 2)
                .frame(width: 36, height: 36)
            
            if isFilled {
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
        }
        .scaleEffect(isFilled ? 0.95 : 1.0)
    }
}
