//
//  PlantViewModel.swift
//  PlantoApp
//
//  Created by rand on 28/10/2025.
//

import Foundation
import UserNotifications

final class PlantViewModel: ObservableObject {
    @Published var reminders: [PlantReminder] = []
    @Published var reminder: PlantReminder = PlantReminder()
    
    var nWatered: Int {
        reminders.filter { $0.isWateredToday }.count
    }
    
    var nProgress: Double {
        guard !reminders.isEmpty else { return 0 }
        return Double(nWatered) / Double(reminders.count)
    }
    
    var lovedText: String {
        "\(nWatered) of your plants feel loved today ✨"
    }
    
    var allWatered: Bool {
        !reminders.isEmpty && reminders.allSatisfy { $0.isWateredToday }
    }
    
    private var isValid: Bool {
        !reminder.name.isEmpty
    }
    
    func toggleWatered(for plant: PlantReminder) {
        if let index = reminders.firstIndex(where: { $0.id == plant.id }) {
            reminders[index].isWateredToday.toggle()
        }
    }
    
    func deleteReminder(_ plant: PlantReminder) {
        if let index = reminders.firstIndex(where: { $0.id == plant.id }) {
            NotificationManager.shared.cancelNotification(for: reminders[index])
            reminders.remove(at: index)
        }
    }
}

extension PlantViewModel {
    func requestNotificationPermission() {
        NotificationManager.shared.requestAuthorization()
    }

    func saveReminder() {
        guard isValid else { return }

        let newPlant = reminder
        reminders.append(newPlant)

        NotificationManager.shared.scheduleDailyWaterNotification(
            for: newPlant,
            atHour: 9,
            minute: 0
        )

        reminder = PlantReminder()
    }
}

