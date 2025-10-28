//
//  NotificationManager.swift
//  PlantoApp
//
//  Created by rand on 28/10/2025.
//
import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, error in
            if let error = error {
                print("❌ Notification auth error:", error)
            } else {
                print("✅ Notification permission:", granted)
            }
        }
    }

    private func makeContent(for reminder: PlantReminder) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Hey! Let's water your plant 🌿"
        content.body = reminder.name.isEmpty
            ? "Don't forget to give some love today ✨"
            : "\(reminder.name) is thirsty right now 💧"
        content.sound = .default
        return content
    }

    private func makeTrigger(hour: Int, minute: Int, repeats: Bool) -> UNCalendarNotificationTrigger {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
    }

    func scheduleDailyWaterNotification(for reminder: PlantReminder, atHour hour: Int, minute: Int) {
        let id = reminder.id.uuidString
        let content = makeContent(for: reminder)
        let trigger = makeTrigger(hour: hour, minute: minute, repeats: true)

        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to schedule:", error)
            } else {
                print("🌿 Scheduled notif for \(reminder.name) at \(hour):\(minute)")
            }
        }
    }

    func cancelNotification(for reminder: PlantReminder) {
        let id = reminder.id.uuidString
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [id])
    }
}
