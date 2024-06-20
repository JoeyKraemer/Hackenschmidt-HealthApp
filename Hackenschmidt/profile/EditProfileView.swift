//
//  EditProfileView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 17.06.24.
//
import HealthKit
import SwiftUI

struct EditProfileView: View {
    @Binding var name: String
    @Binding var weight: Int
    @Binding var height: Int
    @Binding var sex: String
    @Binding var caloriesIntakeGoal: Int
    @Binding var activityLevel: String
    @Binding var notificationsEnabled: Bool
    @Binding var age: Int
    @Binding var body_goal: String
    @StateObject private var supabaseLogic = SupabaseLogic()
    @StateObject private var authViewModel = AuthViewModel.shared

    let notificationHandler = NotificationHandler()

    @Environment(\.presentationMode) var presentationMode

    let healthStore: HKHealthStore
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }

                Section(header: Text("Weight")) {
                    TextField("Weight", text: Binding(
                        get: { "\(weight)" },
                        set: {
                            if let value = Int($0) {
                                weight = value
                            }
                        }
                    ))
                    .keyboardType(.decimalPad)
                }

                Section(header: Text("Height")) {
                    TextField("Height", text: Binding(
                        get: { "\(height)" },
                        set: {
                            if let value = Int($0) {
                                height = value
                            }
                        }
                    ))
                    .keyboardType(.decimalPad)
                }

                Section(header: Text("Sex")) {
                    TextField("Sex", text: $sex)
                }

                Section(header: Text("Calories intake goal")) {
                    TextField("Calories", text: Binding(
                        get: { "\(caloriesIntakeGoal)" },
                        set: {
                            if let value = Int($0) {
                                caloriesIntakeGoal = value
                            }
                        }
                    ))
                    .keyboardType(.decimalPad)
                }

                Section(header: Text("Age")) {
                    TextField("Age", text: Binding(
                        get: { "\(age)" },
                        set: {
                            if let value = Int($0) {
                                age = value
                            }
                        }
                    ))
                    .keyboardType(.decimalPad)
                }

                Section(header: Text("Body Goal")) {
                    TextField("Body Goal", text: $body_goal)
                }

                Section(header: Text("Activity level")) {
                    TextField("Activity level", text: $activityLevel)
                }

                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                        .onChange(of: notificationsEnabled) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "notifications")
                        }
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                saveToHealthKit()
                Task {
                    await supabaseLogic.updateUserProfile(user_id: authViewModel.uid!, name: name, calorie_goal: caloriesIntakeGoal, weight: weight, height: height, sex: sex, activity: activityLevel, body_goal: body_goal, age: age)
                }
                presentationMode.wrappedValue.dismiss()
            })
        }
        .onAppear {
            notificationHandler.askPermission()
        }
    }

    private func saveToHealthKit() {
        let weightValue = Double(weight)
        let heightValue = Double(height)
        let caloriesValue = Double(caloriesIntakeGoal)

        let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
        let caloriesType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!

        let weightQuantity = HKQuantity(unit: HKUnit.gramUnit(with: .kilo), doubleValue: weightValue)
        let heightQuantity = HKQuantity(unit: HKUnit.meterUnit(with: .centi), doubleValue: heightValue)
        let caloriesQuantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: caloriesValue)

        let weightSample = HKQuantitySample(type: weightType, quantity: weightQuantity, start: Date(), end: Date())
        let heightSample = HKQuantitySample(type: heightType, quantity: heightQuantity, start: Date(), end: Date())
        let caloriesSample = HKQuantitySample(type: caloriesType, quantity: caloriesQuantity, start: Date(), end: Date())

        healthStore.save([weightSample, heightSample, caloriesSample]) { success, error in
            if !success {
                // Handle the error
                print("Failed to save HealthKit data: \(String(describing: error))")
            }
        }
    }
}
