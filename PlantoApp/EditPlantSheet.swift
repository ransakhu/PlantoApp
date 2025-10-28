//
//  EditPlantSheet.swift
//  PlantoApp
//
//  Created by rand on 28/10/2025.
//
import SwiftUI

struct EditPlantSheet: View {
    @ObservedObject var vm: PlantViewModel
    let plant: PlantReminder

    let onCancel: () -> Void
    let onDelete: () -> Void
    let onSaveChanges: () -> Void

    @State private var draft: PlantReminder

    init(vm: PlantViewModel,
         plant: PlantReminder,
         onCancel: @escaping () -> Void,
         onDelete: @escaping () -> Void,
         onSaveChanges: @escaping () -> Void) {
        self.vm = vm
        self.plant = plant
        self.onCancel = onCancel
        self.onDelete = onDelete
        self.onSaveChanges = onSaveChanges
        _draft = State(initialValue: plant)
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                RoundActionButton(systemName: "xmark", foreground: .white, background: .black, action: onCancel)
                Spacer()
                Text("Edit Plant")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white.opacity(0.95))
                Spacer()
                RoundActionButton(systemName: "checkmark", foreground: .black, background: .greens) {
                    if let idx = vm.reminders.firstIndex(where: { $0.name == plant.name }) {
                        vm.reminders[idx] = draft
                    }
                    onSaveChanges()
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)

            Form {
                Section {
                    LabeledContent("Plant Name") {
                        TextField("Pothos", text: $draft.name)
                    }
                }

                Section {
                    PickerRow(label: "Room", icon: "location", selection: $draft.room, options: Room.allCases.map { $0 })
                    PickerRow(label: "Light", icon: "sun.max", selection: $draft.light, options: Light.allCases.map { $0 })
                }

                Section {
                    PickerRow(label: "Watering Days", icon: "drop", selection: $draft.wateringDays, options: WateringDays.allCases.map { $0 })
                    PickerRow(label: "Water", icon: "drop", selection: $draft.water, options: Water.allCases.map { $0 })
                }

                Section {
                    Button(role: .destructive) {
                        vm.deleteReminder(plant)
                        onDelete()
                    } label: {
                        Text("Delete Reminder")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
    }
}

