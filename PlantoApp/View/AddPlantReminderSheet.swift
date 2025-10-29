//
//  AddPlantReminderSheet.swift
//  PlantoApp
//
//  Created by rand on 28/10/2025.
//

import SwiftUI

struct AddPlantReminderSheet: View {
    @ObservedObject var vm: PlantViewModel
    let onCancel: () -> Void
    let onSave: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            // ✅ الهيدر
            HStack {
                RoundActionButton(
                    systemName: "xmark",
                    foreground: .white,
                    background: .black,
                    action: onCancel
                )
                
                Spacer()
                
                Text("Set Reminder")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white.opacity(0.95))
                
                Spacer()
                
                RoundActionButton(
                    systemName: "checkmark",
                    foreground: .black,
                    background: .greens,
                    action: onSave
                )
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            // ✅ الفورم
            Form {
                Section {
                    LabeledContent("Plant Name") {
                        TextField("Pothos", text: $vm.reminder.name)
                    }
                }
                
                Section {
                    PickerRow(label: "Room", icon: "location", selection: $vm.reminder.room, options: Room.allCases.map { $0 })
                    PickerRow(label: "Light", icon: "sun.max", selection: $vm.reminder.light, options: Light.allCases.map { $0 })
                }
                
                Section {
                    PickerRow(label: "Watering Days", icon: "drop", selection: $vm.reminder.wateringDays, options: WateringDays.allCases.map { $0 })
                    PickerRow(label: "Water", icon: "drop", selection: $vm.reminder.water, options: Water.allCases.map { $0 })
                }
            }
        }
    }
}

// 🧩 عنصر مساعد لتقليل التكرار
struct PickerRow<T: Identifiable & Hashable & CustomStringConvertible>: View {
    var label: String
    var icon: String
    @Binding var selection: T
    var options: [T]
    
    var body: some View {
        LabeledContent {
            Picker("", selection: $selection) {
                ForEach(options, id: \.id) { option in
                    Text(option.description).tag(option)
                }
            }
            .pickerStyle(.menu)
            .tint(.gray)
        } label: {
            Label(label, systemImage: icon)
                .symbolRenderingMode(.monochrome)
                .foregroundColor(.white)
        }
    }
}
