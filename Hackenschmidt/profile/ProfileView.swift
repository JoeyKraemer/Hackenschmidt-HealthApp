//
//  ProfileView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 17.06.24.
//
import SwiftUI
import HealthKit

struct ProfileView: View {
    @State private var isEditViewPresented = false
    @State private var name: String = "Jane"
    @State private var weight: String = "60 kg"
    @State private var height: String = "175 cm"
    @State private var sex: String = "Female"
    @State private var caloriesIntakeGoal: String = "2,000 cal"
    @State private var activityLevel: String = "Active"
    
    private let healthStore = HKHealthStore()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.purple)
                Text(name)
                    .font(.title)
                    .bold()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Weight")
                        .bold()
                    Spacer()
                    Text(weight)
                }
                HStack {
                    Text("Height")
                        .bold()
                    Spacer()
                    Text(height)
                }
                HStack {
                    Text("Sex")
                        .bold()
                    Spacer()
                    Text(sex)
                }
                HStack {
                    Text("Calories intake goal")
                        .bold()
                    Spacer()
                    Text(caloriesIntakeGoal)
                }
                HStack {
                    Text("Activity level")
                        .bold()
                    Spacer()
                    Text(activityLevel)
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            
            Button(action: {
                isEditViewPresented = true
            }) {
                Text("CHANGE DATA")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
        .padding()
        .sheet(isPresented: $isEditViewPresented) {
            EditProfileView(name: $name, weight: $weight, height: $height, sex: $sex, caloriesIntakeGoal: $caloriesIntakeGoal, activityLevel: $activityLevel, healthStore: healthStore)
        }
        .onAppear {
            requestHealthKitAuthorization()
        }
    }
    
    private func requestHealthKitAuthorization() {
        let healthKitTypesToRead: Set = [
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .height)!,
            HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
            HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        ]
        
        let healthKitTypesToWrite: Set = [
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .height)!,
            HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        ]
        
        healthStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { success, error in
            if !success {
                // Handle the error
                print("HealthKit authorization failed: \(String(describing: error))")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
