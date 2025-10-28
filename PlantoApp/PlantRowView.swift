//
//  PlantRowView.swift
//  PlantoApp
//
//  Created by rand on 28/10/2025.
//

import SwiftUI

struct PlantRowView: View {
    @ObservedObject var viewModel: PlantViewModel
    let plant: PlantReminder
    let onEdit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                
                // ✅ دائرة التشييك
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        viewModel.toggleWatered(for: plant)
                    }
                } label: {
                    WaterToggleCircle(isFilled: plant.isWateredToday)
                }
                .buttonStyle(.plain)
                
                // ✅ باقي الصف (يفتح edit)
                Button(action: onEdit) {
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack(spacing: 4) {
                            Image(systemName: "location")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            Text("in \(plant.room.title)")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        
                        Text(plant.name)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(plant.isWateredToday ? .gray : .white)
                        
                        // ✅ البادجات (Full Sun / 20-50ml)
                        HStack(spacing: 12) {
                            
                            HStack(spacing: 4) {
                                Image(systemName: plant.light.icon)
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.9))
                                Text(plant.light.title)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.08)))
                            .opacity(plant.isWateredToday ? 0.4 : 1.0)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "drop.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.9))
                                Text(plant.water.title)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.08)))
                            .opacity(plant.isWateredToday ? 0.4 : 1.0)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 8)
        }
        .padding(.horizontal, 16)
        .background(Color.black)
    }
}
