//
//  PlantModels.swift
//  PlantoApp
//
//  Created by rand on 28/10/2025.
//
import Foundation

// ROOM
enum Room: String, CaseIterable, Identifiable, Hashable, CustomStringConvertible {
    case Bedroom, LivingRoom, Kitchen, Balcony, Bathroom
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .Bedroom: "Bedroom"
        case .LivingRoom: "Living Room"
        case .Kitchen: "Kitchen"
        case .Balcony: "Balcony"
        case .Bathroom: "Bathroom"
        }
    }
    
    var description: String {
        title
    }
}

// WATERING DAYS
enum WateringDays: String, CaseIterable, Identifiable, Hashable, CustomStringConvertible {
    case everyDay, everyTwoDays, everyThreeDays, onceAWeek, everyTenDays, EveryTwoWeeks
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .everyDay: "Every Day"
        case .everyTwoDays: "Every 2 Days"
        case .everyThreeDays: "Every 3 Days"
        case .onceAWeek: "Once a Week"
        case .everyTenDays: "Every 10 Days"
        case .EveryTwoWeeks: "Every 2 Weeks"
        }
    }
    
    var description: String {
        title
    }
}

// WATER AMOUNT
enum Water: String, CaseIterable, Identifiable, Hashable, CustomStringConvertible {
    case _20_50 , _50_100 , _100_200, _200_300
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case ._20_50: "20-50 ml"
        case ._50_100: "50-100ml"
        case ._100_200: "100-200ml"
        case ._200_300: "200-300ml"
        }
    }
    
    var description: String {
        title
    }
}

// LIGHT
enum Light: String, CaseIterable, Identifiable, Hashable, CustomStringConvertible {
    case fullSun, partialSun, lowLight
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .fullSun: "Full Sun"
        case .partialSun: "Partial Sun"
        case .lowLight: "Low Light"
        }
    }
    
    var icon: String {
        switch self {
        case .fullSun: "sun.max"
        case .partialSun: "sun.max.fill"
        case .lowLight: "sun.min.fill"
        }
    }
    
    var description: String {
        title
    }
}

// مره مهم: struct هذا ما يحتاج تعديل
struct PlantReminder: Identifiable, Hashable {
    let id: UUID = UUID()
    var isWateredToday: Bool = false
    var name: String = ""
    var room: Room = .Bedroom
    var wateringDays: WateringDays = .everyDay
    var water: Water = ._20_50
    var light: Light = .fullSun
}

