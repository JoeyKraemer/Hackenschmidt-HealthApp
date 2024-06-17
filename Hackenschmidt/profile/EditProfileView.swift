//
//  EditProfileView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 17.06.24.
//
import SwiftUI
import HealthKit

struct EditProfileView: View {
    @Binding var name: String
    @Binding var weight: String
    @Binding var height: String
    @Binding var sex: String
    @Binding var caloriesIntakeGoal: String
    @Binding var activityLevel: String
    
    let healthStore: HKHealthStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Weight")) {
                    TextField("Weight", text: $weight)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Height")) {
                    TextField("Height", text: $height)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Sex")) {
                    TextField("Sex", text: $sex)
                }
                
                Section(header: Text("Calories intake goal")) {
                    TextField("Calories intake goal", text: $caloriesIntakeGoal)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Activity level")) {
                    TextField("Activity level", text: $activityLevel)
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                saveToHealthKit()
            })
        }
    }
    
    private func saveToHealthKit() {
        guard let weightValue = Double(weight.replacingOccurrences(of: " kg", with: "")),
              let heightValue = Double(height.replacingOccurrences(of: " cm", with: "")),
              let caloriesValue = Double(caloriesIntakeGoal.replacingOccurrences(of: " cal", with: "")) else {
            return
        }
        
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
