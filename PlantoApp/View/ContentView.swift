import SwiftUI

struct ContentView: View {
    @State private var showSheet: Bool = false
    @State private var navigateToNext: Bool = false
    
    @StateObject private var vm = PlantViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("My Plants 🌱")
                        .font(.system(size: 34, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .padding(.leading, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                        .background(Color.gray)
                        .padding(.bottom, 32)
                }
                
                Image("PlantPic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 315, height: 330)
                    .padding(.top, 80)
                
                Spacer()
                
                Button(action: {
                    showSheet.toggle()
                }) {
                    Text("Set Plant Reminder")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 280, height: 41)
                }
                .buttonStyle(.glassProminent)
                .tint(.greena) // استبدلنا greena -> green مؤقتاً
                .padding(.bottom, 140)
            }
            .background(Color.black.ignoresSafeArea())
            .onAppear {
                // نطلب صلاحيات الاشعارات أول مرة تفتح الشاشة
                vm.requestNotificationPermission()
            }
            .sheet(isPresented: $showSheet) {
                AddPlantReminderSheet(
                    vm: vm,
                    onCancel: {
                        showSheet = false
                    },
                    onSave: {
                        vm.saveReminder()
                        showSheet = false
                        navigateToNext = true
                    }
                )
            }
            .navigationDestination(isPresented: $navigateToNext) {
                ReminderSuccessView(plantvm: vm)
            }
        }
    }
}

#Preview {
    ContentView()
}

