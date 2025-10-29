//
//  ReminderSuccessView.swift
//  PlantoApp
//
//  Created by rand on 28/10/2025.
//
import SwiftUI

struct ReminderSuccessView: View {
    @ObservedObject var plantvm: PlantViewModel
    @State private var showSheet = false
    @State private var selectedPlant: PlantReminder? = nil

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            if plantvm.allWatered {
                VStack(spacing: 24) {
                    Text("My Plants 🌱")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    Spacer()

                    Image("Plant2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)

                    VStack(spacing: 6) {
                        Text("All Done! 🎉")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        Text("All Reminders Completed")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .background(Color.black.ignoresSafeArea())
            } else {
                VStack(spacing: 16) {
                    VStack(alignment: .center, spacing: 12) {
                        Text("My Plants 🌱")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)

                        Divider().background(Color.gray)

                        Text(plantvm.nProgress == 0 ? "Your plants are waiting for a sip 💦" : plantvm.lovedText)
                            .font(.system(size: 15))
                            .foregroundColor(.greens)
                            .frame(maxWidth: .infinity, alignment: .center)

                        ProgressView(value: plantvm.nProgress)
                            .progressViewStyle(.linear)
                            .tint(Color.greens.opacity(0.6))
                            .padding(.horizontal, 24)
                    }

                    List(plantvm.reminders, id: \.name) { plant in
                        PlantRowView(viewModel: plantvm, plant: plant) {
                            selectedPlant = plant
                            showSheet = true
                        }
                        .listRowBackground(Color.black)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.black)
                }
                .background(Color.black.ignoresSafeArea())
            }

            if !plantvm.allWatered {
                Button {
                    selectedPlant = nil
                    showSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.greens.opacity(0.9))
                        .clipShape(Circle())
                        .shadow(color: .greens.opacity(0.4), radius: 10, x: 0, y: 4)
                }
                .padding(.trailing, 24)
                .padding(.bottom, 24)
            }
        }
        .sheet(isPresented: $showSheet) {
            if let plantToEdit = selectedPlant {
                EditPlantSheet(vm: plantvm, plant: plantToEdit, onCancel: { showSheet = false }, onDelete: { showSheet = false }, onSaveChanges: { showSheet = false })
            } else {
                AddPlantReminderSheet(vm: plantvm, onCancel: { showSheet = false }, onSave: {
                    plantvm.saveReminder()
                    showSheet = false
                })
            }
        }
        // إخفاء زر الرجوع الافتراضي في هذه الصفحة
        .navigationBarBackButtonHidden(true)
    }
}
